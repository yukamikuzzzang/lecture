#include <iostream>
using namespace std;

/*
class Data{
	private: int a;
	public:			//생성 + 소멸 순 
		Data(){}	//1
		~Data(){cout<<"Data"<<endl;}	//4
		
	
		int getA() {return a;}
};
class Test:public Data{
	Test(){};		//2 기본생성자 
	~Test(){cout<<"Test"<<endl;};	//3서 
};
int main() {
	Test t(5);
	return 0;
}
*/

/*
class TV{
	private: int size; //protected int size; << 이러면 함수를 사용할 필요 X 
	public:
		TV(){}
		~TV(){}
		TV(int size){this->size = size;}
		int getSize(){return size;}
}; 

class ColorTV: public TV{
	private: string color;
	public:
		ColorTV(){}
		~ColorTV(){}
		ColorTV(int size, string color):TV(size)
		{this->color=color;}
		 string getColor(){return color;} 
		 
		void show()
		{
			cout<<"크기는 "<<getSize()<<"인치, 색은"<<color<<endl;
		}
};

class QLEDTV : public ColorTV{
	private: int price;
	public: 
		QLEDTV(){}
		~QLEDTV(){}
		QLEDTV(int price, int size, string color):ColorTV(size, color){this->price = price;}
		
		void play()
		{
			cout<<"색은 "<<getColor()<<",크기는 "<<getSize()<<"인치, 가격은 "<<price<<endl; 
		}
}; 

class SmartTV :public ColorTV{
	private: string IpAddress;
	public:
		SmartTV(){}
		~SmartTV(){}
		SmartTV(int size, string color, string IpAddress):ColorTV(size, color){this->IpAddress = IpAddress;}
		
		void display()
		{
			cout<<"색은 "<<getColor()<<",크기는 "<<getSize()<<"인치, Ip Address는 "<<IpAddress<<endl;
		}
		
};


int main(){
	ColorTV tv(40,"Green");
	tv.show(); //크기는 40인치, 색은 green 
	QLEDTV qtv(56000000,60,"Red");
	qtv.play(); //색은 Red, 크기는 60인치, 가격은 56000000 
	SmartTV stv(50, "Blue","192.23.5.9");
	stv.display(); //Blue 색, 50인치, IP Address는 192.23.5.9 
	return 0;
}
*/
/*
class Base{
	int a;	//<<public, protected도 결국 private으로 상속받기에 main에서 못씀. 
public:
	Base(int x):a(x){}	//???
	//~Base(){}
	
	int getA(){return a;}
};
class Derived:private Base { //위가 protected 일 떄 아래도 protected를 쓰면 그 기능을 사용할 수 있다. 
	int b;
public: 
	//Derived(){}
	//~Derived(){}
	Derived(int a, int b):Base(a){this->b=b;}
	
	void showB(){cout<<"a="<<getA()<<",b="<<b<<endl;	}
}; 
int main()
{
	Derived x(3,5);
	//x.showB(); //a=3, b=5;
	//x.a=55;	
}
*/
/*
class A{
	public:int mode;
};
class B: virtual public A{
	public:int read;
};
class C: virtual public A{
	public : int write;
};
class D: public B, public C{
	public:bool safe;
};

int main() {
	D aaa;
	aaa.mode = 55;
	cout<<aaa.mode<<endl;
}*/
/*
class Adder{
	protected:
		int add(int a, int b){return a+b;}
};
class Subtractor{
	protected:
		int minus(int a, int b){return a-b;}
};
class Multiplier{
	protected:
		int multiply(int a, int b){return a*b;}
};
class Divider{
	protected:
		int divide(int a, int b){return int(a/b);}
};

//다중상속 
class Calculator : public Adder, public Subtractor, public Multiplier, public Divider{
	public:
		int calc(char op, int a, int b);
};

int Calculator::calc(char op, int a, int b){
	int res = 0;
	switch(op) {
		case '+' : res = add(a,b); break;
		case '-' : res = minus(a,b); break;
		case '*' : res = multiply(a,b); break;
		case '/' : res = divide(a,b); break;
	}
	return res;
}

int main(){
	int a, b;
	char op;
	
	cin>>a>>op>>b;
	Calculator handCalculator;
	cout<<a<<op<<b<<"="<<handCalculator.calc(op, a, b)<<endl;
}
*/


class Product{
protected:
int id, price;
public:
	Product(){}
	~Product(){}
	Product(int id, int price){this->id = id; this->price = price;}
	int getId(){return id;}
	int getPrice(){return price;}

};
class Book : virtual protected Product{
protected:
string author, bookName;
public:
	Book(){}
	~Book(){}
	Book(int id, int price, string bookName, string author):Product(id, price){this->bookName = bookName; this->author = author;}
	Book(string bookName, string author){this->bookName=bookName; this->author=author;}
	Book(string bookName){this->bookName=bookName;}
	string getAutor(){return author;}
	string getBookName(){return bookName;}
};

class eBook : protected Book{ 
string lang;
public:
	eBook(){}
	~eBook(){}
	eBook(int id, int price, string bookName, string author, string lang):Book(bookName, author),Product(id,price){this->lang = lang;}
	
	void show(){ cout<<"번호: "<<getId()<<", "<<getBookName()<<"의 저자는 "<<getAutor()<<"이고 "<<lang<<"로 번역되어 있어 가격은 "<<getPrice()<<"원 입니다."<<endl;};
};

class CompactDisc : virtual protected Product{
protected:
string singer, musicName;
public:
	CompactDisc(){}
	~CompactDisc(){}
	CompactDisc(int id, int price, string singer, string musicName):Product(id,price){this->singer = singer; this->musicName = musicName;}
	CompactDisc(string singer){this->singer = singer;}
	string getMusicName(){return this->musicName = musicName;}
	
	void show(){cout<<"번호: "<<getId()<<", "<<musicName<<"을 부른 사람은 "<<singer<<"이고 가격은 "<<getPrice()<<"원 입니다."<<endl;};
	
};

class VoiceBook : protected Book, protected CompactDisc{
protected:
string maker;
public:
	VoiceBook(){}
	VoiceBook(int id, int price,string bookName,string singer, string maker):Product(id, price),Book(bookName),CompactDisc(singer){this->maker = maker;}
	void show(){cout<<"번호: "<<getId()<<", "<<getBookName()<<"을 "<<maker<<" 소속의 "<<singer<<"이 읽어주면 "<<getPrice()<<endl;}
	
}; 

int main(){
	eBook eb(100,25000,"어린왕자","생텍쥐베리","영어");
	//번호: 100, 어린왕자의 저자는 생텍쥐베리이고 영어로 번역되어 가격은 25,000원 입니다.
	eb.show();
	CompactDisc cd(200,12300,"비틀즈","Yesterday");
	cd.show(); 
	VoiceBook vb(300,35000,"토지","방탄","빅히트");
	vb.show();
	return 0;
}
