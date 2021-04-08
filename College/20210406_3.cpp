#include <iostream>
#include <string> 
#include <string.h>

using namespace std;
class Circle{
	int radius;
public:
	int r;
	string name;
	Circle();
	Circle(string name, int radius);
	~Circle(){}
	
	void setRadius(string n, int r) {name = n, radius = r;}
	//void setName(string n){name = n;}
	double getArea() {return 3.14*radius*radius;}
	double getRound() {return 2*3.14*radius;}
	string getName() {return name;}
	
	void getN(string n) {
		r = radius;
		//if(name == n){
			cout<< name <<"의"<<' ';
			cout<<"면적은 "<< 3.14*r*r<<' ';//원의 면적 출력
			cout<<"둘레는 "<< 2*3.14*r <<endl;//원의 둘레 출력 
		//}
	}
};

Circle::Circle(){
	radius = 1;
}

int main(){
	cout << "생성하고자 하는 원의 갯수?";
	int n, radius;
	string name, other;
	cin >> n; //원의 개수 입력
	
	Circle *pArray = new Circle[n]; //n개의 Circle 배열 생성
	for(int i=0;i<n;i++){
		cout << "원" << i+1 <<"의 이름과 반지름은? "; //프롬프트 출력
		cin>>name; //이름 입력 
		cin>>radius;//반지름 입력
		pArray[i].setRadius(name,radius); //각Circle 객체를 반지름으로 초기화 
		//pArray[i].setName(name);	
	} 
	
	int count = 0; //카운트 변수
	Circle* p = pArray;
	for(int i=0;i<n;i++){
		cout<<p->getName()<<"의"<<' ';
		cout<<"면적은 "<< p->getArea() <<' ';//원의 면적 출력
		cout<<"둘레는 "<< p->getRound() <<endl;//원의 둘레 출력 
		if(p->getArea() >= 100 && p->getArea() <= 200)
			count++;
		p++; 
	}
	cout << endl << "면적이100에서 200 사이인 원의 개수는 " << count << endl;
	
//	name = p->getName();
//	if(strcmp(name,"피자") == 0){
//		cout<<p->getName("피자"); 
//	}

	cout<<"검색하고자 하는 원의 이름은? ";
	cin>>name;
	
	//cout<<p->getName(name);
	
	for(int y=0;y<n;y++){
		p->getN(name);
		p++;
		
//		if(p > 3){
//			break;
//		}
		
	}
	 

	delete [] pArray; //객체 배열 소멸 
	
	return 0; 
}

//둘레도 구해보자. 
