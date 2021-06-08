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
	//벡터 자체가 템플릿 클래스다.
	
	vector <Person> p;
	vector <Person> :: iterator itp;
	p.push_back(Person("진수",23));
	p.push_back(Person("민수",22));
	p.push_back(Person("영수",26));
	
	for(itp = p.begin(); itp!=p.end(); itp++){
		cout<<itp->g_Name()<<endl;
	}
	*/
/*		
	char y;
	for(int z=0;z<5;z++){
		cout<<"값을 입력해주세요." <<endl;
		//cout<<z+1<<"번째 숫자: ";
		cin>>y;
		c.push_back(y);
		//cout<<endl;
	} 
	
	for(itc=c.begin(); itc!=c.end(); itc++){
		cout<<*itc<<endl;
	}
*/	

/*
이름: 5개 입력받기
검색: 특정 이름 
삭제: 특정 이름 삭제 
출력:전부다 
*/

//공백이 있을 경우 getline으로 받는 것이 좋음. 
	vector <string> st;
	vector <string> :: iterator its;
	string name; 
while(true){
	for(int x=0;x<5;x++){
		cout<<"이름?";
		getline(cin,name); 
		st.push_back(name);
	}
	
	//string a;
	cout<<"검색?";
	cin >> name;
	//getline(cin,a);
	
	its = find(st.begin(), st.end(), name);
	cout<<*its<<endl;
	
	cout<<"삭제";
	its = st.erase(its);
	

	/*
	for(int x=0;x<5;x++){
	
		if(c[x] == name){
				its=st.erase(its);
				break;
		} 
	}
	*/	
	cout<<"출력";
	for(its=st.begin(); its!=st.end(); its++){
		cout<<*its<<endl;
	}
	break;
}

return 0;	
}
