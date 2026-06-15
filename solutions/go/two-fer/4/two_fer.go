// Package twofer is short for two for one. Package implements simple operation with string
package twofer

// ShareWith transforms accepted string into sentence
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}

	return "One for " + name + ", one for me."
}
