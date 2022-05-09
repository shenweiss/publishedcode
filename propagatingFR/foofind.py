import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm, colors, colorbar

import mne
from mne import io
from mne.datasets import sample
from mne.viz import plot_topomap
from mne.time_frequency import psd_welch

from fooof import FOOOFGroup
from fooof.bands import Bands
from fooof.analysis import get_band_peak_fg

from fooof.plts.spectra import plot_spectra, plot_spectra_shading

# Import simulation utilities for creating test data
from fooof.sim.gen import gen_power_spectrum, gen_group_power_spectra
from fooof.sim.params import param_iter, Stepper
import scipy.io
from fooof.objs.utils import average_fg, combine_fooofs, compare_info

def foofind(events_out):
    offset=[]
    aperiodic=[]
    eegdata=events_out
    n_channels = 1
    sampling_freq = 2000
    ch_names =['outnp']
    ch_types='eeg'
    info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
    eegdata = np.expand_dims(eegdata, axis=1)
    epochs=mne.EpochsArray(eegdata,info)

    # Calculate power spectra across the the continuous data
    spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=2000)  

    x = range(0, len(spectra))
    for i in x:
        fm = FOOOFGroup()
        freq_range = [2, 60]
        fm.fit(freqs, spectra[i], freq_range)
        aperiodic=fm.get_params('aperiodic_params')
        offset=np.append(offset,(aperiodic[0][0]))

    return(offset)