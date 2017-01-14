using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    public class IngredientsReader
    {
        public static Dictionary<string, Ingredient> Read()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = "Cocktail.ingredients.json";
            var results = new Dictionary<string, Ingredient>();
            using (var stream = assembly.GetManifestResourceStream(resourceName))
            {
                using (var textStream = new StreamReader(stream))
                {
                    using (var reader = new JsonTextReader(textStream))
                    {
                        var ingredients = JObject.Load(reader);
                        foreach (var i in ingredients)
                        {
                            var ingredient = new Ingredient { Name = i.Key, AlcoholByVolume = (int)i.Value["abv"], Taste = (string)i.Value["taste"] };
                            results.Add(ingredient.Name, ingredient);
                        };
                    }
                }
            }
            return results;
        }
    }
}
