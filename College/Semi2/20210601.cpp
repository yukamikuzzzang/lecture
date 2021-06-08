/*
auto(변수를 자동으로 읽어주는 것)이 안된다고 함..
람다식의 개념을 알고... (람다식 또한 dev C++에선 안된다고..) 

템플릿 
객체지향: 같은 이름을 가진 함수를 만들 수 있음.(절차 X)
단, 매개변수가 달라야함.

두 개의 데이터를 교환하는 것. 
a=4 , b=5
tmp = a;
a = b;
b = tmp; 

두 개의 데이터가 실수인 경우 
c=0.3, d=12.5
 ...
 
함수중복의 약점 
 변수의 형이 다를 때마다 계속해서 
 함수를 만들어줘야 한다는 것이 약점.
  
이런 문제를 해결하고자 나온 개념이 템플릿..!

제네릭generic 또는 일반화 
함수나 클래스를 일반화시키고 매개 변수 타입을 지정하여 틀에서
찍어 내듯이 함수나 클래스 코드를 생산하는 기법 

이 기법을 통해 만든 함수를 템플릿이라 부르며
제네릭 클래스 등으로 불림.

<제네릭 기법|으로 만든 >> 템플릿 함수, 템플릿 클래스..> 
제네릭 타입? 일반화를 위해 필요한 문자타입.
 
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
//영역에 있는 값 자체가 완전히 바뀜
//int가 올 때, double로 올 때, float로 올 때 그에 맞게 바뀐다는 뜻. 
{
	T tmp;
	tmp = a;
	a = b;
	b= tmp; //교환 
}
template <class T1, typename T2>
//꺾쇠가 들어가는 제네릭 기법 
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
	
	
	cout<<"큰 값 :"<<bigger(a,b)<<endl;
	cout<<"큰 값 :"<<bigger(c,d)<<endl;
	cout<<"큰 값 :"<<bigger(e,f)<<endl;
	
	return 0;
}
*/

//템플릿 만드는 방법******
//선언 후 리턴 타입 > 함수 이름
//클래스 선언 후 > 클래스 이름
//자바에서도 볼 수 있는 제네릭!
 
//10-4중 dest[i] = (T2)src[i];
//미리 형변환을 시켜줌.

//문자가 숫자로 출력? char에서의 문제..
//템플릿 함수보다 중복함수가 우선..!

/* 템플릿 클래스 선언 
template <class T>
class MyStack {
	int tos;
	T data [100]; // T 타입의 배열
	public:
	MyStack(); //LIFO방식 
	void push(T element);
	T pop();
};
*/

/*
C++ 표준 탬플릿 라이브러리, STL: Standard Template Library
전문가들이 만든 검증된 라이브러리

컨테이너<자료를 담음> + 반복자<요소에 접근> + 알고리즘<템플릿 함수> 
HEMS 자료 참고

*/ 
 
/* ~HEMS 자료 참고~ */
//C++ STL책 한권이 저리 두껍누..

/*STL*************************
알고리즘 종류 외우기

copy merge random rotate equal min remove search
find move replace sort max partition reverse swap..  */
#include<iostream>
#include<vector> 
using namespace std;

int main(){
	int a[200]; 
	//실행할 때 메모리에 할당하는 동적할당. 
	//입력하는 만큼 메모리에 할당하겠다..! 
	double b[200];
	vector <int> v; 
	vector <int> :: iterator it;
	//int면 int.. 사이즈도 따로 정할 필요없음. 
	//#include <vector>!
	//deque 메모리  블록 할당(벡터보다큼..)
	//multi~ 중복을 허용한다는 뜻.
	v.push_back(7);	//뒤에 추가하라.
	v.push_back(67);v.push_back(2);
	v.push_back(39);v.push_back(99);
	cout<<v[2]<<", "<<v.at(1)<<endl; 
	cout<<"크기: "<<v.size()<<","<<"용량: "<<v.capacity()<<endl; 
	//2^1개 보다 더 넣으면 2^2
	//2^2개 보다 더  넣으면 2^3
	//2^3개 보다 더 넣으면 2^4만큼 공간을 확보 
	for(int i=0;i<v.size();i++){
		cout<<v[i]<<" "<<v.at(i)<<" "<<endl;
	}
	cout<<endl;
	for(it=v.begin(); it!=v.end(); it++){
		cout<<*it<<endl;
		//너가 마지막 주소니?
		//아니야
		//출력 후 포인터 값 증가. 
	}
	it= ++v.begin();
	cout<<endl<<*it<<endl;
	it=v.erase(it); 
	it= --v.end();
	cout<<endl<<*it<<endl;
	it=v.insert(it,55);
	//v.end() end 다음 포인터에 해당하는 값이 없다는 걸 말함. 

	vector <char> c;
	vector <char> :: iterator itc;
	//벡터 자체가 템플릿 클래스다.
	
	
	
	char y;
	for(int z=0;z<=5;z++){
		cout<<"값을 입력해주세요." <<endl;
		//cout<<z+1<<"번째 숫자: ";
		cin>>y;
		c[z] = y;
		//cout<<endl;
	} 
	
	for(itc=c.begin(); itc!=c.end(); itc++){
		cout<<*itc<<endl;
	}
		
} 
 
