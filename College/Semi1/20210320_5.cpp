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
	cout<<"a�� �� = "<<a<<",�ּ� = "<<ap<<","<<*ap<<endl;
	*ap=15;
	cout<<"a�� �� = "<<a<<",�ּ� = "<<ap<<","<<*ap<<endl;
	Data d;
	d.show();
	Data *dp=&d;
	dp->show();
	Data ds[3];	//3���� �ּ�. 
	Data *dsp=ds; //Data�� �����ּҸ� �ٷ� �� �� �ִ� �κ�.
	dsp->show();	//d1.show 
	dsp++;
	dsp->show();	//d2.show
	dsp++;
	dsp->show(); 	//d3.show
	
	//Bank bk[3]={Bank("�浿","111-111")}
	
	return 0;
}


/*
Data�� �����ּ�..! 
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

�迭�� �����ϸ� ���� �Ѿ�� �ִٴ� ��..! 
*/
