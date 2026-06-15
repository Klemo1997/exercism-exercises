package raindrops

import "strconv"

// Convert returns string based on given rules applied to number input as specified:
// if number has 3 as a factor, add 'Pling' to the result
// if number has 5 as a factor, add 'Plang' to the result
// if number has 7 as a factor, add 'Plong' to the result
// if number does not have any of 3, 5, or 7 as a factor, the result should be the digits of the number
func Convert(number int) string {
	buffer := ""

	if number%3 == 0 {
		buffer += "Pling"
	}

	if number%5 == 0 {
		buffer += "Plang"
	}

	if number%7 == 0 {
		buffer += "Plong"
	}

	if buffer == "" {
		return strconv.Itoa(number)
	}

	return buffer
}
