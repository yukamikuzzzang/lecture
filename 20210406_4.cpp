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
	cout<<"�̸���?";
	getline(cin,name); //���� ��� cin>>name;
	cout<<a.substr(2,4)<<endl; //0���� ����. (7,3) = the 
	//Ư�� ���ڸ� ������ �� �� 
	cout<<a.find<"e",2)<<endl;
	//����ܾ�� �߿��� e�� �� ���ִ��� ã�� ���..
	//insert, replace, length, erase, clear..
	
	return 0;
}

//�ҽ��� ����, ����� ĸ�� 

//�⺻ 7
//�¸� Ȯ�ν� 8 
// ���ӽ� + ȸ���� 3���̻� 10 
