#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <algorithm>
using namespace std;

/*
class Person{
	string name;
	int age;
public:
	Person(string name, int age){
		this->name = name;
		this->age = age;
	}
	string g_Name(){
		return name;
	}
};
*/
int main(){
	/*
	vector <char> c;
	vector <char> :: iterator itc;
	//���� ��ü�� ���ø� Ŭ������.
	
	vector <Person> p;
	vector <Person> :: iterator itp;
	p.push_back(Person("����",23));
	p.push_back(Person("�μ�",22));
	p.push_back(Person("����",26));
	
	for(itp = p.begin(); itp!=p.end(); itp++){
		cout<<itp->g_Name()<<endl;
	}
	*/
/*		
	char y;
	for(int z=0;z<5;z++){
		cout<<"���� �Է����ּ���." <<endl;
		//cout<<z+1<<"��° ����: ";
		cin>>y;
		c.push_back(y);
		//cout<<endl;
	} 
	
	for(itc=c.begin(); itc!=c.end(); itc++){
		cout<<*itc<<endl;
	}
*/	

/*
�̸�: 5�� �Է¹ޱ�
�˻�: Ư�� �̸� 
����: Ư�� �̸� ���� 
���:���δ� 
*/

//������ ���� ��� getline���� �޴� ���� ����. 
	vector <string> st;
	vector <string> :: iterator its;
	string name; 
while(true){
	for(int x=0;x<5;x++){
		cout<<"�̸�?";
		getline(cin,name); 
		st.push_back(name);
	}
	
	//string a;
	cout<<"�˻�?";
	cin >> name;
	//getline(cin,a);
	
	its = find(st.begin(), st.end(), name);
	cout<<*its<<endl;
	
	cout<<"����";
	its = st.erase(its);
	

	/*
	for(int x=0;x<5;x++){
	
		if(c[x] == name){
				its=st.erase(its);
				break;
		} 
	}
	*/	
	cout<<"���";
	for(its=st.begin(); its!=st.end(); its++){
		cout<<*its<<endl;
	}
	break;
}

return 0;	
}
