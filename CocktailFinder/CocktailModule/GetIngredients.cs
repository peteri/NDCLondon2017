using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Text;
using System.Threading.Tasks;

namespace CocktailModule
{
    [Cmdlet(VerbsCommon.Get,"Ingredient")]
    public class GetIngredients : PSCmdlet
    {
        protected override void ProcessRecord()
        {
            var ingredients=Cocktail.IngredientsReader.Read();
            WriteObject(ingredients, true);
        }
    }
}
