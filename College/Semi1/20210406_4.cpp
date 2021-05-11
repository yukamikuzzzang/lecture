#include <iostream>
#include <string> 


using namespace std;
int t = 100;
int main(){
	string a = "we are";
	a.append(" the");
	a.append(" world");
	cout <<a<<","<<a.length()<<endl;
	string name;
	cout<<"이름은?";
	getline(cin,name); //공백 허용 cin>>name;
	cout<<a.substr(2,4)<<endl; //0부터 시작. (7,3) = the 
	//특정 문자를 추출할 때 사 
	cout<<a.find<"e",2)<<endl;
	//영어단어들 중에서 e가 몇 개있는지 찾는 방법..
	//insert, replace, length, erase, clear..
	
	return 0;
}

//소스는 복사, 결과는 캡쳐 

//기본 7
//승리 확인시 8 
// 게임승 + 회원수 3명이상 10 
