//#include "hearder.h"
#include <iostream>
#include <windows.h>
using namespace std;
class Data{
	private:
		int y;
	public:
		Data(int x) : y(x){}
		
		void show(string n)
		{
			cout<<n<<endl;
		}
		int get(){
			return y*5;
		}
}; 


int main()
{
	int a = 5; float b=5.6f; char name[10] = "Kim";
	string str = "park", str2("lees");
	cout<<"hello \n"<<endl;
	system("color 01"); //색바꾸기 
	cout<<str<<endl;
	system("pause");
	system("cls");	//화면지우기 
	system("color 5f");
	//show("김길동");
	Data d(55); 
	d.show("길동");
	Sleep(2000); //2초
	system("color 3a");
	cout<<d.get()<<endl;
	return 0 ;
}

//cmd 바꾸는 프로그램임. 
