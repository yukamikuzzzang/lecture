#include <iostream>

using namespace std;
class Circle{
	int radius;
public:
	Circle();
	Circle(int r);
	~Circle();
	void setRadius(int r) {radius = r;}
	double getArea() {return 3.14*radius*radius;}
};

Circle::Circle(){
	radius = 1;
}

int main(){
	cout << "생성하고자 하는 원의 개수?";
	int n, radius;
	cin >> n; //원의 개수 입력
	
	Circle *p = pArray = new Circle[n]; //n개의 Circle 배열 생성
	for(int i=0;i<n;i++){
		cout<<p->getArea()<<''; //원의 면적 출력
		if(p->getArea()>= 100 && p ->getArea() <= 200)
			count++;
		p++; 
	} 
	cout<<endl<<"면적이 100에서 200 사이인 원의 개수는 "<< cout<<endl;
	
	delete [] pArray; //객체 배열 소멸 
}
