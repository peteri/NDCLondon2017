using Cocktail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace CocktailFinder
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface ICocktail
    {

        [OperationContract]
        List<Ingredient> GetIngredients();

        [OperationContract]
        List<string> GetRecipeNames();

        [OperationContract]
        List<string> GetByAvailableIngredients(List<string> names);

        [OperationContract]
        Recipe GetRecipe(string name);
    }
}
