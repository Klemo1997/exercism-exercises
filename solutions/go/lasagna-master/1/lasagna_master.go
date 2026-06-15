package lasagna

func PreparationTime(layers []string, preparationTime int) int {
    if preparationTime == 0 {
        return len(layers) * 2
    }

    return len(layers) * preparationTime
}

func Quantities(layers []string) (int, float64) {
	var sauceLayers, noodleLayers int

	for _, layer := range layers {
		if layer == "sauce" {
			sauceLayers++
			continue
		}

		if layer == "noodles" {
			noodleLayers++
		}
	}

	return noodleLayers * 50, float64(sauceLayers) * 0.2
}

func AddSecretIngredient(friendIntredients []string, myIngredients []string) {
	lastFriendIngredient := friendIntredients[len(friendIntredients)-1]
	myIngredients[len(myIngredients)-1] = lastFriendIngredient
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
    scaledQuantities := []float64{}

    for _, quantity := range quantities {
        scaledQuantities = append(scaledQuantities, quantity * float64(portions) / 2.0)
    }

    return scaledQuantities
}
