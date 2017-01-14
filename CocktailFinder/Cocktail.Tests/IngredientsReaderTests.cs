using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Cocktail.Tests
{
    [TestClass]
    public class IngredientsReaderTests
    {
        [TestMethod]
        public void TestIngredientsReaderFromResource()
        {
            var ingredients = IngredientsReader.Read();
            var aperol = ingredients["Aperol"];
            Assert.IsNotNull(aperol);
            Assert.AreEqual("Aperol", aperol.Name);
            Assert.AreEqual(11, aperol.AlcoholByVolume);
            Assert.AreEqual("bitter", aperol.Taste);
        }
    }
}
