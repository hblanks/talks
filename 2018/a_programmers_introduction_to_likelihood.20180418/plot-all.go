package main

import (
	"image/color"
	"math"
	"math/big"
	"fmt"
	"strconv"

	"gonum.org/v1/plot"
	"gonum.org/v1/plot/plotter"
	"gonum.org/v1/plot/vg"
)

type intticks struct{}

func (intticks) Ticks(min, max float64) []plot.Tick {
	ticks := make([]plot.Tick, 0)
	for i := int(min); i < int(max); i++ {
		ticks = append(ticks, plot.Tick{float64(i), strconv.Itoa(i)})
	}
	return ticks
}

// Returns binomial coefficient as a float
func binomial(n, x int) float64 {
	i, f := new(big.Int), new(big.Float)
	binom, _ := f.SetInt(i.Binomial(int64(n), int64(x))).Float64()
	return binom
}

// Returns the likelihood of pi, given that we observed x successes out
// of n trials,but after dividing out the binomial coefficient.
func likelihood(pi float64, x int, n int) float64 {
	return math.Pow(pi, float64(x)) * math.Pow(1 - pi, float64(n - x))
}

func plotProbability(p *plot.Plot) {
	pi := 1e-4
	n := 500
	xMax := 5

	p.Title.Text = fmt.Sprintf(
		"Probability for 1-%d DOA drives in %d, given rate of %0.2f%%",
		xMax,
		n,
		pi * 100)
	p.X.Label.Text = "Number of DOA drives"
	p.Y.Label.Text = "Probability"
	p.X.Min, p.X.Max = 0, float64(xMax)
	p.Y.Min, p.Y.Max = 0, 1
	p.X.Tick.Marker = intticks{}

	values := plotter.Values{}
	for x := 0; x <= xMax; x++ {
		p := binomial(n, x) * likelihood(pi, x, n)
		values = append(values, p)
	}
	bars, err := plotter.NewBarChart(values, vg.Length(1))
	if err != nil {
		panic(err)
	}
	bars.Color = color.RGBA{B: 255, A: 255}
	bars.Offset = vg.Length(10)
	bars.Width = vg.Length(20)
	bars.LineStyle.Width = vg.Length(0.05)
	p.Add(bars)
}

func plotLikelihood(p *plot.Plot) {
	x, n := 4, 500
	mle := float64(4) / 500

	p.Title.Text = fmt.Sprintf("Likelihood of DOA failure rate (pi), given x = %d, n = %d", x, n)
	p.X.Label.Text = "DOA failure rate (pi)"
	p.Y.Label.Text = "Likelihood L(pi|x)"

	binom := binomial(n, x)
	L := plotter.NewFunction(
		func(pi float64) float64 { return binom * likelihood(pi, x, n)})
	L.Color = color.RGBA{B: 255, A: 255}
	p.Add(L)
	p.X.Min, p.X.Max = 0, 0.05
	p.Y.Min, p.Y.Max = 0, binom * likelihood(mle, 4, 500) * 1.1 // some headroom for scale
}

func plotLLR(p *plot.Plot) {
	x, n := 4, 500
	mle := float64(4) / 500

	p.Title.Text = fmt.Sprintf("-2 Log-likelihood ratio of DOA failure rate (pi), given x = %d, n = %d", x, n)
	p.X.Label.Text = "DOA failure rate (pi)"
	p.Y.Label.Text = "-2 * log-likelihood, -2 * ln L(pi|x)"

	L := plotter.NewFunction(
		func(pi float64) float64 {
			return -2 * math.Log(likelihood(pi, x, n)/likelihood(mle, x, n))})
	L.Color = color.RGBA{B: 255, A: 255}
	p.Add(L)
	p.Add(plotter.NewFunction(func(pi float64) float64 {return 3.841459}))
	p.X.Min, p.X.Max = 0.000000001, 0.05
	p.Y.Min, p.Y.Max = 0, 4 // some headroom for scale
}

func plotToPng(f func(*plot.Plot), path string) {
	p, err := plot.New()
	if err != nil {
		panic(err)
	}
	f(p)
	if err := p.Save(7 * vg.Inch, 4.5 * vg.Inch, path); err != nil {
		panic(err)
	}
}

func main() {
	plotToPng(plotProbability, "probability.png")
	plotToPng(plotLikelihood, "likelihood.png")
	plotToPng(plotLLR, "llr.png")
}
