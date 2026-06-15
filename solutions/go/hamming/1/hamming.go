package hamming

import "errors"

// Distance calculates the Hamming Distance between two DNA strands
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return -1, errors.New("sequence lengths differ, therefore it is impossible to calculate hamming distance between them")
	}

	distance := 0

	// convert b in rune array
	// so it is index accessible
	bRune := []rune(b)

	for i, char := range a {
		if char != bRune[i] {
			distance++
		}
	}

	return distance, nil
}
