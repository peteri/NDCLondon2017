using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    public class RecipesReader
    {
        public static Dictionary<string, Recipe> Read(Dictionary<string, Ingredient> ingredients)
        {
            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = "Cocktail.recipes.json";
            var results = new Dictionary<string, Recipe>();
            using (var stream = assembly.GetManifestResourceStream(resourceName))
            {
                using (var textStream = new StreamReader(stream))
                {
                    using (var reader = new JsonTextReader(textStream))
                    {
                        var recipes = JObject.Load(reader).First.Children();
                        foreach (var r in recipes.Children())
                        {
                            var recipe = new Recipe
                            {
                                Name = (string)r["name"],
                                Glass = (string)r["glass"],
                                Category = (string)r["category"],
                                Preparation = (string)r["preparation"],
                                Garnish = (string)r["garnish"]
                            };
                            foreach (var i in r["ingredients"])
                            {
                                var name = (string)i["ingredient"];
                                var special = (string)i["special"];
                                if (name != null)
                                {
                                    if (ingredients.ContainsKey(name))
                                    {
                                        var ingredient = new IngredientWithQuantity
                                        {
                                            Ingredient = ingredients[name],
                                            Amount = (double)i["amount"],
                                            Unit = (string)i["unit"]
                                        };
                                        recipe.Ingredients.Add(ingredient);
                                    }
                                    else
                                    {
                                        throw new Exception(string.Format("Missing Ingredient {0} in {1}", name, recipe.Name));
                                    }
                                }
                                if (special != null)
                                {
                                    Debug.Print("{0} - {1}", recipe.Name, special);
                                }
                            }
                            results.Add(recipe.Name, recipe);
                        };
                    }
                }
            }
            return results;
        }
    }
}
