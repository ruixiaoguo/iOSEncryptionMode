## iOS生成私钥p12公钥der文件(包括安卓文件)

##### 这些天有很多同学来问.p12和 .der生成的方法,索性就写一篇文章来解答,对称加密/非对称加密,这里说一下 两者的区别:

* （1）对称加密加密与解密使用的是同样的密钥，所以速度快，但由于需要将密钥在网络传输，所以安全性不高。
* （2） 非对称加密使用了一对密钥，公钥与私钥，所以安全性高，但加密与解密速度慢。
* （3）解决的办法是将对称加密的密钥使用非对称加密的公钥进行加密，然后发送出去，接收方使用私钥进行解密得到对称加密的密钥，然后双方可以使用对称加密来进行沟通。

### 一.生成RSA 公私钥

#### 你需要创建一个文件夹,并且cd进去,以便存储生成的文件)

##### 1.生成强度是 1024 的 RSA 私钥

$ openssl genrsa -out private.pem 1024
执行以代码生成一个私钥，Pem文件，其实Pem文件就是一般的文本格式;

##### 2.创建证书请求(这里按提示填写证书信息),这时候会生成一个csr文件

$ openssl req -new -key private.pem -out rsacert.csr

##### 3.生成证书并且签名，有效期10年

$ openssl x509 -req -days 3650 -in rsacert.csr -signkey private.pem -out rsacert.crt

##### 4.转换格式-将 PEM 格式文件转换成 DER 格式

$ openssl x509 -outform der -in rsacert.crt -out rsacert.der

##### 5.导出P12文件

$ openssl pkcs12 -export -out p.p12 -inkey private.pem -in rsacert.crt


#### 最后生成了两个我们要用的文件，一个p12文件和一个der文件，der文件是公钥，p12文件是私钥。及 /.crt / .csr. / .pem

#### iOS端只需要der公钥和p12私钥
#### 若使用安卓的文件请自行选择以上不同格式的文件


