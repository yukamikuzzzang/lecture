#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <algorithm>
#include <queue>

using namespace std;

int main(){
	
//	cout<<endl;
//	queue <int> qu;
//	qu.push(34); qu.push(45); qu.push(78); //�Է�
//	 
//	for(int i=0;i<qu.size();i++){
//		qu.pop(); //ť�� ������ ������
//		cout<<qu.back()<<" "; //qu.front() :��, back() �� 
//	}
//	cout<<endl;
	//�Ǻ���ġ ����: 0 1 1 2 3 5 8 13 21 ...
	queue <int> que;
	
	int i = 0;
	que.push(0); que.push(1);
	while(i < 20){
	

	//int first = 0;
	//int second = 1;

	cout<<que.front()<<" ";
	que.push(que.front() + que.back());
	que.pop();

	
	i++;
	}
	
	
	
	return 0;
}
