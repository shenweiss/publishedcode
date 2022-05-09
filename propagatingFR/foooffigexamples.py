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

# Non-propagating 

aperiodic=[]
peak=[]
gaussian=[]
rsquared=[]

# out NP

file0='/data/downstate/wip/completed_analyses/part 2/4163foofexample3.mat'
matfile_vars = scipy.io.loadmat(file0)
eegdata=matfile_vars['events_out_np']
n_channels = 1
sampling_freq = 2000
ch_names =['outnp']
ch_types='eeg'
info = mne.create_info(ch_names=ch_names, ch_types=ch_types, sfreq=sampling_freq)
eegdata = np.expand_dims(eegdata, axis=1)
epochs=mne.EpochsArray(eegdata,info)

# Calculate power spectra across the the continuous data
spectra, freqs = psd_welch(epochs, fmin=1, fmax=60, tmin=0, tmax=1000, n_overlap=250, n_fft=2000)  
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
np_aperiodic=afm.get_params('aperiodic_params')
np_peak=afm.get_params('peak_params')
np_gauss=afm.get_params('gaussian_params')
np_rsqr=afm.get_params('r_squared')
plt.text(33,2.3, np_rsqr, fontsize=18)
plt.text(33,2.1, np_peak, fontsize=18)
plt.text(33,1.9, np_aperiodic, fontsize=18)
plt.title('out np')
plt.ylim(ymin=-1,ymax=3)
plt.savefig('/data/downstate/wip/completed_analyses/part 2/4163edge3fooofoutnp.eps',format='eps')
# out p

eegdata=matfile_vars['events_out_p']
n_channels = 1
sampling_freq = 2000
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
p_aperiodic=afm.get_params('aperiodic_params')
p_peak=afm.get_params('peak_params')
p_gauss=afm.get_params('gaussian_params')
p_rsqr=afm.get_params('r_squared')
plt.text(33,2.3, p_rsqr, fontsize=18)
plt.text(33,2.1, p_peak, fontsize=18)
plt.text(33,1.9, p_aperiodic, fontsize=18)
plt.title('out p')
plt.ylim(ymin=-1,ymax=3)
plt.savefig('/data/downstate/wip/completed_analyses/part 2/4163edge3fooofoutp.eps',format='eps')
# in np

eegdata=matfile_vars['events_in_np']
n_channels = 1
sampling_freq = 2000
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
p_aperiodic=afm.get_params('aperiodic_params')
p_peak=afm.get_params('peak_params')
p_gauss=afm.get_params('gaussian_params')
p_rsqr=afm.get_params('r_squared')
plt.text(33,2.3, p_rsqr, fontsize=18)
plt.text(33,2.1, p_peak, fontsize=18)
plt.text(33,1.9, p_aperiodic, fontsize=18)
plt.title('in np')
plt.ylim(ymin=-1,ymax=3)
plt.savefig('/data/downstate/wip/completed_analyses/part 2/4163edge3fooofinnp.eps',format='eps')
# in p

eegdata=matfile_vars['events_in_p']
n_channels = 1
sampling_freq = 2000
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
p_aperiodic=afm.get_params('aperiodic_params')
p_peak=afm.get_params('peak_params')
p_gauss=afm.get_params('gaussian_params')
p_rsqr=afm.get_params('r_squared')
plt.text(33,2.3, p_rsqr, fontsize=18)
plt.text(33,2.1, p_peak, fontsize=18)
plt.text(33,1.9, p_aperiodic, fontsize=18)
plt.title('in p')
plt.ylim(ymin=-1,ymax=3)
plt.savefig('/data/downstate/wip/completed_analyses/part 2/4163edge3fooofinp.eps',format='eps')
print("done")

