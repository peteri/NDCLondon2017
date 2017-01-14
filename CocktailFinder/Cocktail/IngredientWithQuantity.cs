using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    [DataContract]
    public class IngredientWithQuantity
    {
        [DataMember]
        public Ingredient Ingredient { get; set; }
        [DataMember]
        public double Amount { get; set; }
        [DataMember]
        public string Unit { get; set; }
    }
}
