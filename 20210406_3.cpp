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
			cout<< name <<"��"<<' ';
			cout<<"������ "<< 3.14*r*r<<' ';//���� ���� ���
			cout<<"�ѷ��� "<< 2*3.14*r <<endl;//���� �ѷ� ��� 
		//}
	}
};

Circle::Circle(){
	radius = 1;
}

int main(){
	cout << "�����ϰ��� �ϴ� ���� ����?";
	int n, radius;
	string name, other;
	cin >> n; //���� ���� �Է�
	
	Circle *pArray = new Circle[n]; //n���� Circle �迭 ����
	for(int i=0;i<n;i++){
		cout << "��" << i+1 <<"�� �̸��� ��������? "; //������Ʈ ���
		cin>>name; //�̸� �Է� 
		cin>>radius;//������ �Է�
		pArray[i].setRadius(name,radius); //��Circle ��ü�� ���������� �ʱ�ȭ 
		//pArray[i].setName(name);	
	} 
	
	int count = 0; //ī��Ʈ ����
	Circle* p = pArray;
	for(int i=0;i<n;i++){
		cout<<p->getName()<<"��"<<' ';
		cout<<"������ "<< p->getArea() <<' ';//���� ���� ���
		cout<<"�ѷ��� "<< p->getRound() <<endl;//���� �ѷ� ��� 
		if(p->getArea() >= 100 && p->getArea() <= 200)
			count++;
		p++; 
	}
	cout << endl << "������100���� 200 ������ ���� ������ " << count << endl;
	
//	name = p->getName();
//	if(strcmp(name,"����") == 0){
//		cout<<p->getName("����"); 
//	}

	cout<<"�˻��ϰ��� �ϴ� ���� �̸���? ";
	cin>>name;
	
	//cout<<p->getName(name);
	
	for(int y=0;y<n;y++){
		p->getN(name);
		p++;
		
//		if(p > 3){
//			break;
//		}
		
	}
	 

	delete [] pArray; //��ü �迭 �Ҹ� 
	
	return 0; 
}

//�ѷ��� ���غ���. 
