using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    [DataContract]
    public class Ingredient
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public int AlcoholByVolume { get; set; }
        [DataMember]
        public string Taste { get; set; }
    }
}
