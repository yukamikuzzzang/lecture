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
	system("color 01"); //���ٲٱ� 
	cout<<str<<endl;
	system("pause");
	system("cls");	//ȭ������� 
	system("color 5f");
	//show("��浿");
	Data d(55); 
	d.show("�浿");
	Sleep(2000); //2��
	system("color 3a");
	cout<<d.get()<<endl;
	return 0 ;
}

//cmd �ٲٴ� ���α׷���. 
