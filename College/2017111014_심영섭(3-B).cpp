//�ۼ�-����(Ctrl+S)-����(F11)
//#include <stdio.h> //��ó���� 
#include <iostream>
//using std::endl;
using namespace std; //std�ȿ� cout, endl, cin(scanf) �� 
//std::cout<<"hello"<<std::cout<<endl;


/*namespace kim{
	int a;void show(){}
}
namespcae park{
	int b;
}
using namespace kim

int main()//os���� ó�� �������� �Լ� 
{
	//printf("Hello"); scanf()
	cout<<"hello"<<endl;
	cout<<"World"<<endl;
	kim::a=100;
	park::b=300;
	return 0;
	
}*/

/*int main(){
	cout << "�ʺ� �Է��ϼ���>> ";
	
	int width;
	cin >> width;
	
	cout << "���̸� �Է��ϼ���>> ";
	
	int height;
	cin >> height;
	
	int area = width * height;
	cout << "������ " << area << endl;
	return 0;
}*/

/*
int x = 50; //��������  
int getArea(int a,int b){	//�Լ��� ���� ���� �� 
	return a * b;
}
void line();//�Լ� ���� 
int main(){
	int width, height;
	line();
	cout << "�ʺ�� ���̸� �Է��ϼ���. ";
	cin>>width>>height;
	cout<<"�簢���� ������? "<<getArea(width,height)<<endl;	
	line();

void line(){
	for(int i=1;i<x;i++){
		cout<<"-";	
	}
	cout<<endl;
} 

int a=10, b=15, c;
c = (a+b,a-b); 
cout<<c;
}

*/
/*
int main(){
	int n = 3;
	cout<<n<<endl;
	int *p; //�����ͺ��� 
	p = &n; //n�� ����ִ� �ּ���  �� 
	cout<<p<<endl<<*p<<endl;
	*p=555;
	cout<<*p<<endl;
	//�ش� �ּ��� 4byte�� ���ϸ� ���� �ּҷ� �Ѿ. 
}
// �޸� �����ϴ� ���� ����ϴ� ������ ���� 
*/
#include <time.h>
#include <stdlib.h>

void getSort(int arr[],int k); //�Լ��� ����  

int main(){
	int i = 0;
	int sum = 0; 
	int MAX;
	srand(time(NULL));
	//cout<<"������ ��: "<<rand()%100+1<<endl; //1~100ȭ ������ ������ �� 
	int x[10];
	int z = sizeof(x)/sizeof(x[0]);
	cout<<"�迭�� ũ��: "<<z<<endl;
	//�������� ���� 
	
	
	do{
		x[i] = rand()%100+1;
		cout<<"/"<<x[i];
		sum += x[i];
		
		if(i<1){
			MAX = x[i];
		}else{
			if(MAX < x[i]){
				MAX = x[i];
			}
		}
		i++;
		
	}while(i<10);
	
	cout<<endl;
	
	int avg = sum/(sizeof(x)/sizeof(x[0]));
	cout<<"�ִ�: "<<MAX<<endl;
	cout<<"�հ�: "<<sum<<endl; 
	cout<<"���: "<<avg<<endl;
	
	
	getSort(x,z);
	//int x[10] = {0,};
	//�迭 �� ���� 0���� �ʱ�	 
}

void getSort(int arr[], int k){
/*
	int something;
	do{
		if(k<1){
			something = arr[k];
		}
		else if(arr[k-1]>arr[k]){
			something = arr[k-1];
			arr[k-1] = arr[k];
			arr[k] = something;
		}else{
			
		}
	}while(k<10); 
	
	
	int x,y,temp;
	
	for(x=0;x<10;x++){
		cout<<arr[x]<<" ";	
	}
*/		
	int x,temp;
	
	for(x=0;x<k+1;x++){
		if(arr[x]>arr[x+1]){
			cout<<arr[x]<<endl;
			temp = arr[x];arr[x]=arr[x+1];arr[x+1]=temp;//��ȯ  
			x=0;
		}
		else{
			continue;
		}
		
		
	}
	for(x=0;x<10;x++){
		cout<<arr[x]<<" ";	
	}
	cout<<endl;

}

