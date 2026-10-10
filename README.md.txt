# DSP Signal Generation, Spectrum Analysis, and Noise Filtering

A lightweight, base MATLAB implementation demonstrating core Digital Signal Processing (DSP) concepts without relying on external toolboxes. 

---

## 🚀 Project Overview
This project simulates a noisy multi-tone signal, analyzes its frequency spectrum using the Fast Fourier Transform (FFT), applies both a simple smoothing filter and a custom windowed-sinc Finite Impulse Response (FIR) low-pass filter, and quantifies performance improvement using **Signal-to-Noise Ratio (SNR)**.

### Key Steps Implemented:
1. **Signal Generation:** Combines two distinct sinusoidal tones ($50\text{ Hz}$ and $120\text{ Hz}$) sampled at $1\text{ kHz}$ and corrupts them with additive white Gaussian noise.
2. **Spectral Analysis:** Computes a single-sided amplitude spectrum via base MATLAB `fft()`.
3. **Filtering Techniques:**
   - **Moving Average Filter:** Simple temporal smoothing (window size = 5).
   - **Custom Windowed-Sinc FIR Filter:** Hand-crafted ideal low-pass impulse response shaped by a Hamming window ($f_c = 150\text{ Hz}$, order $M = 50$).
4. **Quantitative Evaluation:** Calculates and logs the SNR gain achieved by each filtering stage relative to the clean reference signal.

---

## 📊 Results & Visualizations

### Time-Domain Comparison
![Time Domain Results](results/time_domain.png)

### Frequency-Domain Spectrum
![Frequency Domain Results](results/frequency_domain.png)

---

## 💻 Getting Started

### Prerequisites
* **MATLAB** (Base installation; no specialized Signal Processing Toolboxes required).

### Running the Code
1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git