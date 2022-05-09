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

def part2foof(out_np, out_p, in_np, in_p):

# out np 
    eegdata=out_np
    sampling_freq = 2000
    ch_names =['outnp']
    ch_types='eeg'
    info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
    eegdata = np.expand_dims(eegdata, axis=1)
    epochs=mne.EpochsArray(eegdata,info)

    # Calculate power spectra across the the continuous data
    spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=1000)  
    # Initialize a FOOOFGroup object, with desired settings

    fooofobjs=[];
    for i in range(spectra.shape[0]):
        fg = FOOOFGroup(peak_width_limits=[1, 6], min_peak_height=0.15,
                        peak_threshold=2., max_n_peaks=6, verbose=False)
                        # Define the frequency range to fit
        freq_range = [2, 60]
        fg.fit(freqs, spectra[i], freq_range)
        fooofobjs.append(fg)

    fm=combine_fooofs(fooofobjs)
    bands=Bands({'delta': [2, 6]})
    afm = average_fg(fm, bands, avg_method='median')
    afm.plot()
    o_np_aperiodic=afm.get_params('aperiodic_params')
    o_np_peak=afm.get_params('peak_params')
    o_np_gauss=afm.get_params('gaussian_params')
    o_np_rsqr=afm.get_params('r_squared')

    # out p
    eegdata=out_p
    ch_names =['outp']
    ch_types='eeg'
    info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
    eegdata = np.expand_dims(eegdata, axis=1)
    epochs=mne.EpochsArray(eegdata,info)

    # Calculate power spectra across the the continuous data
    spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=1000)  
    # Initialize a FOOOFGroup object, with desired settings

    fooofobjs=[];
    for i in range(spectra.shape[0]):
        fg = FOOOFGroup(peak_width_limits=[1, 6], min_peak_height=0.15,
                        peak_threshold=2., max_n_peaks=6, verbose=False)
                        # Define the frequency range to fit
        freq_range = [2, 60]
        fg.fit(freqs, spectra[i], freq_range)
        fooofobjs.append(fg)

    fm=combine_fooofs(fooofobjs)
    plt.figure()
    bands=Bands({'delta': [2, 6]})
    afm = average_fg(fm, bands, avg_method='median')
    afm.plot()
    o_p_aperiodic=afm.get_params('aperiodic_params')
    o_p_peak=afm.get_params('peak_params')
    o_p_gauss=afm.get_params('gaussian_params')
    o_p_rsqr=afm.get_params('r_squared')

    # in np
    eegdata=in_np
    ch_names =['in np']
    ch_types='eeg'
    info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
    eegdata = np.expand_dims(eegdata, axis=1)
    epochs=mne.EpochsArray(eegdata,info)

    # Calculate power spectra across the the continuous data
    spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=1000)  
    # Initialize a FOOOFGroup object, with desired settings

    fooofobjs=[];
    for i in range(spectra.shape[0]):
        fg = FOOOFGroup(peak_width_limits=[1, 6], min_peak_height=0.15,
                        peak_threshold=2., max_n_peaks=6, verbose=False)
                        # Define the frequency range to fit
        freq_range = [2, 60]
        fg.fit(freqs, spectra[i], freq_range)
        fooofobjs.append(fg)

    fm=combine_fooofs(fooofobjs)
    plt.figure()
    bands=Bands({'delta': [2, 6]})
    afm = average_fg(fm, bands, avg_method='median')
    afm.plot()
    i_np_aperiodic=afm.get_params('aperiodic_params')
    i_np_peak=afm.get_params('peak_params')
    i_np_gauss=afm.get_params('gaussian_params')
    i_np_rsqr=afm.get_params('r_squared')

    # in p
    eegdata=in_p
    ch_names =['in p']
    ch_types='eeg'
    info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
    eegdata = np.expand_dims(eegdata, axis=1)
    epochs=mne.EpochsArray(eegdata,info)

    # Calculate power spectra across the the continuous data
    spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=1000)  
    # Initialize a FOOOFGroup object, with desired settings

    fooofobjs=[];
    for i in range(spectra.shape[0]):
        fg = FOOOFGroup(peak_width_limits=[1, 6], min_peak_height=0.15,
                        peak_threshold=2., max_n_peaks=6, verbose=False)
                        # Define the frequency range to fit
        freq_range = [2, 60]
        fg.fit(freqs, spectra[i], freq_range)
        fooofobjs.append(fg)

    fm=combine_fooofs(fooofobjs)
    plt.figure()
    bands=Bands({'delta': [2, 6]})
    afm = average_fg(fm, bands, avg_method='median')
    afm.plot()
    i_p_aperiodic=afm.get_params('aperiodic_params')
    i_p_peak=afm.get_params('peak_params')
    i_p_gauss=afm.get_params('gaussian_params')
    i_p_rsqr=afm.get_params('r_squared')

    return(o_np_aperiodic,o_p_aperiodic,i_np_aperiodic,i_p_aperiodic,o_np_peak,o_p_peak,i_np_peak,i_p_peak,o_np_gauss,o_p_gauss,i_np_gauss,i_p_gauss,o_np_rsqr,o_p_rsqr,i_np_rsqr,i_p_rsqr)