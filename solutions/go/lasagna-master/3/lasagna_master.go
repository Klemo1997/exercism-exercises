package lasagna

const (
  	defaultPrepMinutesPerLayer = 2
	noodlesGramsPerLayer = 50
	sauceLitersPerLayer  = 0.2
)

func PreparationTime(layers []string, preparationTime int) int {
    if preparationTime == 0 {
        return len(layers) * defaultPrepMinutesPerLayer
    }

    return len(layers) * preparationTime
}

func Quantities(layers []string) (int, float64) {
	var sauceLayers, noodleLayers int

	for _, layer := range layers {
    	switch layer {
        case "sauce":
            sauceLayers++
        case "noodles":
            noodleLayers++
        }
	}

	return noodleLayers * noodlesGramsPerLayer, float64(sauceLayers) * sauceLitersPerLayer
}

func AddSecretIngredient(friendIngredients []string, myIngredients []string) {
    friendIngredientsLen, myIngredientsLen := len(friendIngredients), len(myIngredients)
    
    if friendIngredientsLen == 0 || myIngredientsLen == 0 {
        return
    }
    
	myIngredients[myIngredientsLen-1] = friendIngredients[friendIngredientsLen-1]
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
    scaledQuantities := make([]float64, len(quantities))

    for i, quantity := range quantities {
        scaledQuantities[i] = quantity * float64(portions) / 2.0
    }

    return scaledQuantities
}
