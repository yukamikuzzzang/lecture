#include <iostream>
#include <cstring>
using namespace std;

/*
class Rect; 
class RectManager{
	public:
		bool equals(Rect t, Rect s); //equals �Լ� �� 
		void copy(Rect& dest, Rect& src);
};
class Rect{
	int width, height;
public:
//	Rect(){}
	Rect(int width = 0, int height = 0){
		this->width=width; this->height=height; }
	friend bool equals(Rect r, Rect s); //������ �Լ�  
	friend class RectManager;	//�ٸ� Ŭ���� ��ü�� �������.. 
	friend bool RectManager::equals(Rect r, Rect s); //�ٸ� Ŭ������ ����Լ��� ������� ���� 
};

bool RectManager::equals(Rect r, Rect s){ //RectManager Ŭ������ equals() ����� ������� ���� 
	if(r.width == s.width && r.height==s.height) return true;
	else return false;	
}
void RectManager::copy(Rect& dest, Rect& src){ 
	dest.width = src.width; dest.height = src.height;
}

bool equals (Rect r, Rect s){	//�ܺ��Լ� 
	if(r.width == s.width && r.height==s.height) return true;
	else return false;
}

int main()
{
	Rect a(3,4), b(4,5), c, e(3,4), f(3,4);
	if(equals(a,b)) cout<<"equal"<<endl;
	else cout << "not equal" <<endl;
	RectManager man;
	man.copy(b,a);
	if(man.equals(a,b)) cout << "equal" <<endl;
	else cout<<"not equal"<<endl; //equal
	return 0;
 } 
 */
//class Test{
//	void display();
//};
//
//class Data{
//	int a ,b;
//public:
//	void show();
//	friend void print();
//	friend Test::display();
//	friend Test;
//};
////Test�� Data�� friend / Test�� Data�� ���� ��.
// void prnit() //�ܺ� �Լ�
//{
// 	
//}
// 
class Data{
	int x,y;
public:
	void show(); // ���� ��� �Լ� 
	Data(int x=0, int y=0){ //����Ʈ �Ű�����, �ƹ��͵� ���ٸ� 0 
		this->x = x;
		this->y = y; 
	}
	friend Data operator-(Data c, Data d); //������ �Լ�
	Data operator+(int z);
	Data operator-(int a);
	Data operator+(Data c);
		
};
void Data::show(){
	cout<<"x="<<x<<", "<<"y="<<y<<endl;
}
Data Data::operator+(int z)
{
	x=this->x+z; y=this->y+z;
	return *this; //���� ��ġ�� �ش��ϴ� ������ �� 
}
Data Data::operator-(int a){
	x=this->x-a; y=this->y-a;
	return *this;	
}
Data Data::operator+(Data c){
	Data tmp;
	tmp.x = this -> x + c.x;
	tmp.y = this -> y + c.y;
	return tmp;	
}
Data operator-(Data c, Data d){
	Data tmp;
	tmp.x = c.x - d.x;
	tmp.y = c.y - d.y;
	return tmp;
}




class Test{
	int x;
public:	
	void show();
	Test(int x=0) {
		this->x = x;
	}
	Test operator+=(int a);
	Test operator-=(int b);
};
Test Test::operator+=(int a){
	x = this->x + a;
	return *this;
}
Test Test::operator-=(int b){
	x = this->x+b;
	return *this;
}
void Test::show(){
	cout<<x<<endl;
}




class Color {
	int r,g,b;
public:
	Color (int r=0, int g=0, int b=0) {
		this->r = r;
		this->g = g;
		this->b = b;
	}
	void show();
	friend Color operator+(int a, Color& b);
	Color operator+(Color c);
	bool operator==(Color d);
};
Color operator+(int a, Color& b){

	if(b.r + a <= 255){
		b.r = a + b.r;
	}else {
		b.r = 255;
	}
	if(b.g + a <= 255){
		b.g = a + b.g;
	}else {
		b.g = 255;
	}
	if(b.b + a <= 255){
		b.b = a + b.b;
	}else {
		b.b = 255;
	}
	return b;
}
Color Color::operator+(Color c){
	Color color;
	color.r = this->r + c.r;
	color.g = this->g + c.g;
	color.b = this->b + c.b;
	return color;
}
void Color::show(){
	cout<<this->r<<", "<<this->g<<", "<<this->b<<" ";
}
bool Color::operator==(Color d){
	//Color color;
	if((this->r == d.r) && (this->g == d.g) && (this->b == d.b)){
		return true;
	}
	else{
		return false;
	}
}

class Sample{
int x,y;
	public:
		Sample(int x = 0, int y = 0){
			this->x = x;
			this->y = y;
		}
		void show();
		Sample operator*(Sample a);
		Sample operator-(Sample b); 
};
void Sample::show(){
	cout<<this->x<<", "<<this->y<<endl;
}
Sample Sample::operator*(Sample a){
	x = this->x * a.x;
	y = this->y * a.y;
	return *this;	
}
Sample Sample::operator-(Sample b){
	x = this->x - b.x;
	y = this->y - b.y;
	return *this;
}

class Food{
int a;
string st;
public:
	Food(int a = 0, string st = ""){
		this->a = a;
		this->st = st;
	}
	void print();
	void operator-(int z);
	friend Food operator+(int y, Food& x);
};

void Food::print(){
	cout<<"�޴�: "<<this->st<<", ���� : "<<this->a<<endl;
}

void Food::operator-(int z){
	a -= z;
	//return *this;
}

Food operator+(int y, Food& x){
	x.a = x.a + y;
	return x;
}
//Color operator+(int a){
//	Color color;
//	r = this->r + a;
//	g = this->g + a;
//	c = this->c + a;
//	return *this;
//}
 int main(){
// 	int a=2,b=3, c=a+b;
// 	cout << c << endl;
//��ü�� ������ ���� ������ �ߺ��� ���
//��ü + ��ü, ��ü + ����, ���� + ��ü
/*
	Data a(4,5), b(2,3), c(5,7), s;
	a.show(); //x=4, y=5
	b.show(); //x=2, y=3
	s.show(); //x=0, y=0
	cout<<"------------------"<<endl;
	a+4; //a.operator+(4) -> x=8, y=9 : A
	a.show(); 
	b.operator-(2); //b-2; -> x=0, y=1 : B
	b.show();
	s = a+b; // x=8, y=10
	s.show();
	s = c-b; //x=5, y=6
	s.show(); //with �ܺ��Լ� with friend 
	//��ü��  Ŭ�������� ����� ��
	//��ü ��, ��ü�� ������, ������ ��ü�� ������ �����ϰ� ���ִ� operator 
	s=a+b; s.show();
	s=c-b; s.show();
	s=a+b-c; s.show();
*/

/*	Test t(100);
	int r;
	while(true)
	{
		cout<<"number= ?";
		cin>>r;
		if(r==0) break;
		else{
			t.operator+=(r);
			t.show(); // 5�� �Է½ÿ� 105 
		}	
//		else if(r<0){
//			t.operator-=(r);
//			t.show(); //-10�� ���� �� 95	
//		}
	}
*/
	
	
/*	
	Color red(255,0,0), green(0,255,0), blue(0,0,255), s;
	s = red + green;
	//s.show();
	Color yellow(255,255,0);
	
	if(s == yellow) {
	    cout << "�����"<<endl;
	}
	else {
		cout<<"����� �ƴմϴ�."<<endl;
	}
	2+blue; //�ܺ��Լ�: ���� + ��ü
	blue.show(); //2, 2, 255 
*/	
	
	
/*	
	Sample a(45,23), b(5,7), c(2,4), t;
	t = a - b * c;//�����Լ� 
	t.show(); //(35,-5)
*/	
	Food f1(3500,"���"), f2(2800, "������");
	f1.print();	//�޴�: ���, ����:3500 
	f2.print(); //�޴�: ������, ���� : 2800 
	f1 - 500;	//�����Լ� 
	f1.print(); //�޴�:���, ���� : 3000 
	700 + f2; 	//�ܺ��Լ� 
	f2.print();	//�޴�: ������, ���� : 3100
	 
 	return 0;
 }
 
 
