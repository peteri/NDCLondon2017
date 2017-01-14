using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    [DataContract]
    public class Recipe
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Glass { get; set; }
        [DataMember]
        public string Category { get; set; }
        [DataMember]
        public List<IngredientWithQuantity> Ingredients { get; set; }
        [DataMember]
        public string Garnish { get; set; }
        [DataMember]
        public string Preparation { get; set; }

        public Recipe()
        {
            Ingredients = new List<IngredientWithQuantity>();
        }
    }
}
