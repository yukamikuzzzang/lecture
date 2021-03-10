//작성-저장(Ctrl+S)-실행(F11)
//#include <stdio.h> //전처리기 
#include <iostream>
//using std::endl;
using namespace std; //std안에 cout, endl, cin(scanf) 등 
//std::cout<<"hello"<<std::cout<<endl;


/*namespace kim{
	int a;void show(){}
}
namespcae park{
	int b;
}
using namespace kim

int main()//os에서 처음 읽혀지는 함수 
{
	//printf("Hello"); scanf()
	cout<<"hello"<<endl;
	cout<<"World"<<endl;
	kim::a=100;
	park::b=300;
	return 0;
	
}*/

/*int main(){
	cout << "너비를 입력하세요>> ";
	
	int width;
	cin >> width;
	
	cout << "높이를 입력하세요>> ";
	
	int height;
	cin >> height;
	
	int area = width * height;
	cout << "면적은 " << area << endl;
	return 0;
}*/

/*
int x = 50; //전역변수  
int getArea(int a,int b){	//함수가 위에 있을 때 
	return a * b;
}
void line();//함수 원형 
int main(){
	int width, height;
	line();
	cout << "너비와 높이를 입력하세요. ";
	cin>>width>>height;
	cout<<"사각형의 면적은? "<<getArea(width,height)<<endl;	
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
	int *p; //포인터변수 
	p = &n; //n에 들어있는 주소의  값 
	cout<<p<<endl<<*p<<endl;
	*p=555;
	cout<<*p<<endl;
	//해당 주소의 4byte를 더하면 다음 주소로 넘어감. 
}
// 메모리 관리하는 곳에 사용하는 포인터 변수 
*/
#include <time.h>
#include <stdlib.h>

void getSort(int arr[],int k); //함수의 원형  

int main(){
	int i = 0;
	int sum = 0; 
	int MAX;
	srand(time(NULL));
	//cout<<"임의의 수: "<<rand()%100+1<<endl; //1~100화 사이의 임의의 수 
	int x[10];
	int z = sizeof(x)/sizeof(x[0]);
	cout<<"배열의 크기: "<<z<<endl;
	//오름차순 정렬 
	
	
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
	cout<<"최댓값: "<<MAX<<endl;
	cout<<"합계: "<<sum<<endl; 
	cout<<"평균: "<<avg<<endl;
	
	
	getSort(x,z);
	//int x[10] = {0,};
	//배열 안 값을 0으로 초기	 
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
			temp = arr[x];arr[x]=arr[x+1];arr[x+1]=temp;//교환  
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

