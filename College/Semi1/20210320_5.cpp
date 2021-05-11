#include<iostream>
#include<string>
#include<windows.h>
#include<conio.h>
using namespace std;

class Data{
	int a,b;
public:
	void show(){
		cout<<a<<b<<endl;
	}	

};

int main(){
	
	int a = 10;
	int *ap=&a;
	cout<<"a의 값 = "<<a<<",주소 = "<<ap<<","<<*ap<<endl;
	*ap=15;
	cout<<"a의 값 = "<<a<<",주소 = "<<ap<<","<<*ap<<endl;
	Data d;
	d.show();
	Data *dp=&d;
	dp->show();
	Data ds[3];	//3개의 주소. 
	Data *dsp=ds; //Data의 시작주소를 바로 알 수 있는 부분.
	dsp->show();	//d1.show 
	dsp++;
	dsp->show();	//d2.show
	dsp++;
	dsp->show(); 	//d3.show
	
	//Bank bk[3]={Bank("길동","111-111")}
	
	return 0;
}


/*
Data의 시작주소..! 
D1 
a
b
show 

D2
a
b
show

D3
a
b
show 

배열로 구성하면 딱딱 넘어갈수 있다는 점..! 
*/
