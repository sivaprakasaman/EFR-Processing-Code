# EFR Processing - Andrew Sivaprakasam, Summer 2019

The following scripts/methods were designed to calculate and analyze Phase Locking Values (PLVs) and spectral magnitudes of _**both**_ human and chinchilla Envelope Following Responses (EFRs). 

The math equations that were used can be found in the appendix of a [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3724813/#c29) by Li Zhu, [Hari Bharadwaj](https://github.com/haribharadwaj), Jing Xia, and Barbara Shinn-Cunningham. Human data pre-processing was done in [MNE](https://martinos.org/mne/stable/index.html) and also made use of functions found in the [ANLffr](https://github.com/SNAPsoftware/ANLffr) package.

## Pre-Processing

The data that can be loaded into the main script, `EFR_Processing.m`, must be in a *.mat* format. Chinchilla data from NEL should be directly compatible, so long as it is a *.mat*. 

However, data collected in a *.bdf* format must be passed through the python `bdf2mat.py` script found in the **MNE_code** subfolder, in order to be processed properly. 

`bdf2mat(froot,fs,Fs_new,hpf,t_stim,topchans,trial_name)` simply converts the *.bdf* into a *.mat* format that can be read by the main script, `EFR_Processing.m`. It also prints out multi-tapered PLV and Spectral Magnitudes of the averages of all trials (not truncated, but epoch'd). 


**Example:**
```
trial_name = 'SQ25'    
froot = "C:\\Users\\racqu\\Documents\\Research\\Purdue\\HumanData\\AS\\"+trial_name+'\\'
fs = 16384
Fs_new = 4e3
hpf = 70
t_stim = [0.0,1.5] 
topchans = [31] 


bdf2mat(froot,fs,Fs_new,hpf,t_stim,topchans,trial_name)
```

`trial_name` - the name of the condition/stimulus you're testing
`froot` - root directory of all conditions
`fs` - sampling frequency (Hz) of your data
`hpf` - cutoff frequency for high pass filtering of the data
`t_stim` - the window you're interested in pulling the data for the *.mat* file from
`topchans` -  channel of interest (don't believe my code works with multiple channels yet)

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
