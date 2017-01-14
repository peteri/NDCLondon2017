using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail.Tests
{
    [TestClass]
    public class RecipesReaderTests
    {
        [TestMethod]
        public void TestRecipeReaderFromResource()
        {
            var ingredients = IngredientsReader.Read();
            var recipes = RecipesReader.Read(ingredients);
            var americano = recipes["Americano"];
            Assert.IsNotNull(americano);
            Assert.AreEqual("Americano", americano.Name);
            Assert.AreEqual("old-fashioned", americano.Glass);
            Assert.AreEqual("Before Dinner Cocktail", americano.Category);
            StringAssert.Contains(americano.Garnish, "orange");
            StringAssert.Contains(americano.Preparation, "filled with ice cubes");
            Assert.AreEqual(2, americano.Ingredients.Count);
            // Slightly naughty as the order matters
            Assert.AreEqual("Campari", americano.Ingredients[0].Ingredient.Name);
            Assert.AreEqual(3, americano.Ingredients[0].Amount);
            Assert.AreEqual("cl", americano.Ingredients[0].Unit);
            Assert.AreEqual("Vermouth - Sweet Red", americano.Ingredients[1].Ingredient.Name);
            Assert.AreEqual(3, americano.Ingredients[1].Amount);
            Assert.AreEqual("cl", americano.Ingredients[1].Unit);
        }
    }
}
