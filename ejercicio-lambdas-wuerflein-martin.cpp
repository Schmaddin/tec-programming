
using namespace std;
#include <iostream>
#include <functional>
#include <vector>
#include <string>         // std::string
#include <algorithm>  //for_each


// http://mariusbancila.ro/blog/2009/02/24/lambdas-in-c/
template < class T >
std::vector< T > Filter(const std::vector< T >& sequence,
                        function< bool (T) > predicate)
{
   std::vector< T > result;
 
   for(auto it = sequence.begin(); it != sequence.end(); ++it)
      if(predicate(*it))
         result.push_back(*it);
 
   return result;
}
///

int main()
{
	

	// function, que encontra este numero
	function<int()> find=[]()-> int   
	{
	int i=1;
	while(true)   // continuo hastas encontras
	{
	
	// hace strings de los numeros y de 2*...5*
	vector<string> stringsV {std::to_string(i*2),std::to_string(i*3),std::to_string(i*4),std::to_string(i*4),std::to_string(i*5)};
	
	string control=std::to_string(i);
	
	//
	function<bool (string)> hasSameDigits=[=](string a)      // (int &) puede estar un problem porque...que pasa como & se cambia/elimina -> "Dangling Pointer" 
	{

	
	for ( int i = 0 ; i < control.length(); i++)
 	{
       
       size_t n1 = std::count(control.begin(), control.end(), control[i]);
       size_t n2 = std::count(a.begin(), a.end(), control[i]);
       
       if(n1!=n2)
       {
       // cout<<control<<" "<<a<<" -> this number not"<<endl;
       return false;
	   }
 	}
	return true;
	};

   // Filtering del Vector con hasSameDigits
    vector<string> newstring=Filter(stringsV,hasSameDigits);
	
	
	// si el tamano de los vectores es la misma
	if(newstring.size()==stringsV.size())
	{
	cout<<"here we are"<<endl;
	return i;   // return el numero de este iteration
	}

	i++;
	}
	
	};
	
	int j=find();
	
	cout<<j<<" "<<" 2x: "<<j*2<<" 3x: "<<j*3<<" 4x: "<<j*4<<" 5x: "<<j*5<<endl;
	
	return 0;
}

