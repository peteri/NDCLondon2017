using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;

namespace Cocktail.Tests
{
    [TestClass]
    public class RecipeFinderTests
    {
        [TestMethod]
        public void TestRecipeFinder()
        {
            // Arrange
            var ingredients = IngredientsReader.Read();
            var inCupboard = new List<Ingredient>();
            inCupboard.Add(ingredients["Gin"]);
            inCupboard.Add(ingredients["Campari"]);
            inCupboard.Add(ingredients["Vermouth - Sweet Red"]);
            // Act
            var finder = new RecipeFinder(RecipesReader.Read(ingredients));
            var canMake = finder.GetByAvailableIngredients(inCupboard);
            // Assert
            Assert.IsTrue(canMake.Contains("Americano"));
            Assert.IsTrue(canMake.Contains("Negroni"));
            Assert.AreEqual(2, canMake.Count);
        }
    }
}
