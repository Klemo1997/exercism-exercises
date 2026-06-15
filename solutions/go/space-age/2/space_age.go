package space

// Planet type alias
type Planet string

// Number of seconds obtained in 1 Earth year
const yearToSecondsRatio = 31556952

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
func Age(seconds float64, planet Planet) float64 {
	years := getYearsFromSeconds(seconds)

	return years / getYearsRatioToEarth(planet)
}

// Convert seconds to years
func getYearsFromSeconds(seconds float64) float64 {
	return seconds / yearToSecondsRatio
}

// Get ratio of orbital periods of given planet to earth years
// or panic if this information is not contained in map
func getYearsRatioToEarth(planet Planet) float64 {
	if val, ok := planetToRatio[planet]; ok {
		return val
	}

	panic("Invalid planet " + planet)
}
