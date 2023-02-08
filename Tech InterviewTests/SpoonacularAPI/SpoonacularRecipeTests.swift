@testable import Tech_Interview
import XCTest

class SpoonacularRecipeTests: XCTestCase {
    func testObjectDecodesCorrectly() throws {
        let decoder = JSONDecoder()

        let object = try decoder.decode(SpoonacularRecipe.self, from: spoonacularRecipeJSON.data(using: .utf8)!)

        XCTAssertEqual(
            object,
            SpoonacularRecipe(
                id: 782_585,
                title: "Cannellini Bean and Asparagus Salad with Mushrooms",
                image: URL(string: "https://spoonacular.com/recipeImages/782585-556x370.jpg")!,
                summary: "Cannellini Bean and Asparagus Salad with Mushrooms requires approximately <b>45 minutes</b> from start to finish. This main course has <b>482 calories</b>, <b>31g of protein</b>, and <b>6g of fat</b> per serving. This gluten free, dairy free, lacto ovo vegetarian, and vegan recipe serves 6 and costs <b>$1.35 per serving</b>. 309 people were impressed by this recipe. Head to the store and pick up grain mustard, sea salt, lemon zest, and a few other things to make it today. It is brought to you by foodandspice.blogspot.com. Taking all factors into account, this recipe <b>earns a spoonacular score of 70%</b>, which is pretty good. Similar recipes are <a href=\"https://spoonacular.com/recipes/cannellini-bean-salad-422994\">Cannellini Bean Salad</a>, <a href=\"https://spoonacular.com/recipes/refreshing-cannellini-bean-salad-113127\">Refreshing Cannellini Bean Salad</a>, and <a href=\"https://spoonacular.com/recipes/cannellini-and-green-bean-salad-33177\">Cannellini-and-Green Bean Salad</a>.",
                instructions: "Rinse the cannellini beans and soak for 8 hours or overnight in several inches of water. Drain and rinse, then transfer to a medium saucepan and cover with fresh water. Add the curry leaves or bay leaf and bring to a boil. Reduce heat to medium-low, cover, and simmer for 1 hour or until the beans are tender but not falling apart. Drain and transfer to a large salad bowl.Meanwhile, snap the woody ends off of the asparagus spears and steam the spears for 6 minutes or until just tender but still retaining their crunch. Transfer to the salad bowl.Now cook the mushrooms. Heat the oil in a large skillet over high heat. As soon as the oil is hot, drop in the mushrooms and cook, stirring constantly, for 5 minutes or until the mushrooms begin to brown and lose some of their liquid. Transfer to the bowl with the asparagus.To make the dressing, combine the tarragon, lemon zest, garlic, lemon juice, olive oil and mustard in a small food processor or blender. Process until smooth.Pour the dressing over the salad, season with salt and pepper, and toss. Serve at room temperature or chilled."
            )
        )
    }
}
