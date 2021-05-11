#include <iostream>
#include <string>
using namespace std;
class Test{
private:
	int a; double b;
public:
	Test(){a=1; b=1.2;}
	Test(int a, double b){
		this -> a = a;
		this -> b = b;
	}
	Test(int a){
		this -> a = a; b=7.8;
	}
	~Test(){}
	void show();
}; 
//마치c언어에서의 포인터와 비슷한 역할. -> 
void Test::show()
{
	cout<<a<<","<<b<<endl;
}

int main()
{
	Test t;
	t.show();
	Test *tp = &t; tp -> show();
	Test s[]={Test(3,4.5), Test(5), Test()};
	
	s[0].show();
	s[1].show();
	s[2].show();
	Test *sp = s;
	
	cout<<"---------"<<endl;
	for(int i=0;i<3;i++){	
		(sp+i)-> show();
		//sp++ -> show();
		//sp -> show(); sp++;
		//s[i].show();			//배열로서 접근 
		 
//cout<<sp<<endl;		
//3,4.5
//0x6ffdb0
//5,7.8
//0x6ffdb0
//1,1.2
//0x6ffdb0


	}
//	int a= 10;
//	int *p = &a;
//	cout<<p<<endl<<*p<<endl;
//	int b[] = {2,7,4,5,6,5,4};
//	int *bp = b;
//	cout<<*bp<<","<<*(bp+2)<<","<<bp[3]<<endl;			 
	return 0;
}

//배열 b의 시작주소에 있는 값을 보여줌. 
//*(bp+1) = bp[1] 하면 다음 배열에 있는 값을 보여줌.
//포인터 변수로 찍어도 배열 변수로 찍어도 됨. 

//내 클래스에 멤버라는 뜻. this ->(this 포인터) 


//Test *sp = s;
//s[]의 시작주소를 찍어줌.
 
 /*
 메모리
 1.코드영역:코드
 2.데이터영역:전역변수,static변수(프로그램 시작시 할당, 프로그램 종료시 해제)
 3.힙(heap)영역:동적할당영역(new로 할당, delete로 해제)
 4.스택(stack)영역:매개변수, 지역변수(해당함수실행시 할당, 함수 종료시 해제)
 
 *변수, 클래스 배열 등은 stack 영역(정적할당, 컴파일시에 할당)
 *동적할당은 런(실행)시에 할당하고 직접 접근 불가
 그러므로 스택영역에 포인터 변수를 만들어 놓고 접근.
 
 c언어에선 malloc() / free() 라이브러리 함수 사용(동적메모리 할당)
 new 연산자를 이용 기본 메모리, 배열, 객체, 객체 배열 할당 가능.
 delete연산자로 반환. 
 */
