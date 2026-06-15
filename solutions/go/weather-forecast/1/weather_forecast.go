// Package weather provides tools for weather forecasting.
package weather

// CurrentCondition represents a variable that holds current weather condition.
var CurrentCondition string

// CurrentLocation represents a variable that holds current location of forecast.
var CurrentLocation string

// Forecast returns formatted string of given weather condition in given location.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
