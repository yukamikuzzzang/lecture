/*
auto(������ �ڵ����� �о��ִ� ��)�� �ȵȴٰ� ��..
���ٽ��� ������ �˰�... (���ٽ� ���� dev C++���� �ȵȴٰ�..) 

���ø� 
��ü����: ���� �̸��� ���� �Լ��� ���� �� ����.(���� X)
��, �Ű������� �޶����.

�� ���� �����͸� ��ȯ�ϴ� ��. 
a=4 , b=5
tmp = a;
a = b;
b = tmp; 

�� ���� �����Ͱ� �Ǽ��� ��� 
c=0.3, d=12.5
 ...
 
�Լ��ߺ��� ���� 
 ������ ���� �ٸ� ������ ����ؼ� 
 �Լ��� �������� �Ѵٴ� ���� ����.
  
�̷� ������ �ذ��ϰ��� ���� ������ ���ø�..!

���׸�generic �Ǵ� �Ϲ�ȭ 
�Լ��� Ŭ������ �Ϲ�ȭ��Ű�� �Ű� ���� Ÿ���� �����Ͽ� Ʋ����
��� ������ �Լ��� Ŭ���� �ڵ带 �����ϴ� ��� 

�� ����� ���� ���� �Լ��� ���ø��̶� �θ���
���׸� Ŭ���� ������ �Ҹ�.

<���׸� ���|���� ���� >> ���ø� �Լ�, ���ø� Ŭ����..> 
���׸� Ÿ��? �Ϲ�ȭ�� ���� �ʿ��� ����Ÿ��.
 
 <class T>
 
 template <class T>
 template <typename T>
 
 template <class T1, class T2, ...>
*/
  
#include <iostream>
using namespace std;

/*
class Circle{
	int radius;
public:
		Circle(int radius = 1){this->radius = radius;}
		int getRadius() {return radius;}
};
template <class T>
void myswap(T &a, T &b) 
//������ �ִ� �� ��ü�� ������ �ٲ�
//int�� �� ��, double�� �� ��, float�� �� �� �׿� �°� �ٲ�ٴ� ��. 
{
	T tmp;
	tmp = a;
	a = b;
	b= tmp; //��ȯ 
}
template <class T1, typename T2>
//���谡 ���� ���׸� ��� 
void myswap(T1 &a, T2 &b) 
{
	T1 tmp;
}

template <typename T>
T bigger(T a, T b){
	if(a>b) return a;
	else return b;	
}

int main(){
	int a=5, b=7;
	myswap(a,b);
	cout<<"a="<<a<<",b="<<b<<endl;
	double c=2.3, d=5.7;
	myswap(c,d);
	cout<<"c="<<c<<",d="<<d<<endl;
	char e = 'T',  f='Y';
	myswap(e, f);
	cout<<"e="<<e<<",f="<<f<<endl;
	
//	int g=11, h=10.77;
//	myswap(g,h);
//	cout<<"g="<<g<<",h="<<h<<endl;
	
	Circle donut(5), pizza(20);
	myswap(donut,pizza);
	cout<<"donut="<<donut.getRadius() <<",pizza="<<pizza.getRadius()<<endl;
	
	
	cout<<"ū �� :"<<bigger(a,b)<<endl;
	cout<<"ū �� :"<<bigger(c,d)<<endl;
	cout<<"ū �� :"<<bigger(e,f)<<endl;
	
	return 0;
}
*/

//���ø� ����� ���******
//���� �� ���� Ÿ�� > �Լ� �̸�
//Ŭ���� ���� �� > Ŭ���� �̸�
//�ڹٿ����� �� �� �ִ� ���׸�!
 
//10-4�� dest[i] = (T2)src[i];
//�̸� ����ȯ�� ������.

//���ڰ� ���ڷ� ���? char������ ����..
//���ø� �Լ����� �ߺ��Լ��� �켱..!

/* ���ø� Ŭ���� ���� 
template <class T>
class MyStack {
	int tos;
	T data [100]; // T Ÿ���� �迭
	public:
	MyStack(); //LIFO��� 
	void push(T element);
	T pop();
};
*/

/*
C++ ǥ�� ���ø� ���̺귯��, STL: Standard Template Library
���������� ���� ������ ���̺귯��

�����̳�<�ڷḦ ����> + �ݺ���<��ҿ� ����> + �˰���<���ø� �Լ�> 
HEMS �ڷ� ����

*/ 
 
/* ~HEMS �ڷ� ����~ */
//C++ STLå �ѱ��� ���� �β���..

/*STL*************************
�˰��� ���� �ܿ��

copy merge random rotate equal min remove search
find move replace sort max partition reverse swap..  */
#include<iostream>
#include<vector> 
using namespace std;

int main(){
	int a[200]; 
	//������ �� �޸𸮿� �Ҵ��ϴ� �����Ҵ�. 
	//�Է��ϴ� ��ŭ �޸𸮿� �Ҵ��ϰڴ�..! 
	double b[200];
	vector <int> v; 
	vector <int> :: iterator it;
	//int�� int.. ����� ���� ���� �ʿ����. 
	//#include <vector>!
	//deque �޸�  ��� �Ҵ�(���ͺ���ŭ..)
	//multi~ �ߺ��� ����Ѵٴ� ��.
	v.push_back(7);	//�ڿ� �߰��϶�.
	v.push_back(67);v.push_back(2);
	v.push_back(39);v.push_back(99);
	cout<<v[2]<<", "<<v.at(1)<<endl; 
	cout<<"ũ��: "<<v.size()<<","<<"�뷮: "<<v.capacity()<<endl; 
	//2^1�� ���� �� ������ 2^2
	//2^2�� ���� ��  ������ 2^3
	//2^3�� ���� �� ������ 2^4��ŭ ������ Ȯ�� 
	for(int i=0;i<v.size();i++){
		cout<<v[i]<<" "<<v.at(i)<<" "<<endl;
	}
	cout<<endl;
	for(it=v.begin(); it!=v.end(); it++){
		cout<<*it<<endl;
		//�ʰ� ������ �ּҴ�?
		//�ƴϾ�
		//��� �� ������ �� ����. 
	}
	it= ++v.begin();
	cout<<endl<<*it<<endl;
	it=v.erase(it); 
	it= --v.end();
	cout<<endl<<*it<<endl;
	it=v.insert(it,55);
	//v.end() end ���� �����Ϳ� �ش��ϴ� ���� ���ٴ� �� ����. 

	vector <char> c;
	vector <char> :: iterator itc;
	//���� ��ü�� ���ø� Ŭ������.
	
	
	
	char y;
	for(int z=0;z<=5;z++){
		cout<<"���� �Է����ּ���." <<endl;
		//cout<<z+1<<"��° ����: ";
		cin>>y;
		c[z] = y;
		//cout<<endl;
	} 
	
	for(itc=c.begin(); itc!=c.end(); itc++){
		cout<<*itc<<endl;
	}
		
} 
 
