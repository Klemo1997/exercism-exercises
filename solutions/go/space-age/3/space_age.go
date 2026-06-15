package space

import "fmt"

// Planet type alias
type Planet string

// Map of planets orbital period ratio to earth years
var planetToRatio = map[Planet]float64{
	"Earth":   1,
	"Mercury": 0.2408467,
	"Venus":   0.61519726,
	"Mars":    1.8808158,
	"Jupiter": 11.862615,
	"Saturn":  29.447498,
	"Uranus":  84.016846,
	"Neptune": 164.79132,
}

// Age : Calculate amount of orbital periods from seconds on given planet
func Age(seconds float64, planet Planet) (float64, error) {
	if _, ok := planetToRatio[planet]; !ok {
		return 0, fmt.Errorf("unknown planet %q", planet)
	}

	return seconds / 31556952 / planetToRatio[planet], nil
}
