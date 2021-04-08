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
//��ġc������ �����Ϳ� ����� ����. -> 
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
		//s[i].show();			//�迭�μ� ���� 
		 
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

//�迭 b�� �����ּҿ� �ִ� ���� ������. 
//*(bp+1) = bp[1] �ϸ� ���� �迭�� �ִ� ���� ������.
//������ ������ �� �迭 ������ �� ��. 

//�� Ŭ������ ������ ��. this ->(this ������) 


//Test *sp = s;
//s[]�� �����ּҸ� �����.
 
 /*
 �޸�
 1.�ڵ念��:�ڵ�
 2.�����Ϳ���:��������,static����(���α׷� ���۽� �Ҵ�, ���α׷� ����� ����)
 3.��(heap)����:�����Ҵ翵��(new�� �Ҵ�, delete�� ����)
 4.����(stack)����:�Ű�����, ��������(�ش��Լ������ �Ҵ�, �Լ� ����� ����)
 
 *����, Ŭ���� �迭 ���� stack ����(�����Ҵ�, �����Ͻÿ� �Ҵ�)
 *�����Ҵ��� ��(����)�ÿ� �Ҵ��ϰ� ���� ���� �Ұ�
 �׷��Ƿ� ���ÿ����� ������ ������ ����� ���� ����.
 
 c���� malloc() / free() ���̺귯�� �Լ� ���(�����޸� �Ҵ�)
 new �����ڸ� �̿� �⺻ �޸�, �迭, ��ü, ��ü �迭 �Ҵ� ����.
 delete�����ڷ� ��ȯ. 
 */
