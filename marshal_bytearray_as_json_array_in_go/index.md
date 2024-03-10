# golang的json中的byte数组编码



golang的中json，marshal byte数组会默认对byte数组进行base64编码，编码成string，重写MarshalJSON方法保留原始数据

```
package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"
	"strings"
)

type JSONableSlice []byte

func (u JSONableSlice) MarshalJSON() ([]byte, error) {
	var result string
	if u == nil {
		result = "null"
	} else {
		result = strings.Join(strings.Fields(fmt.Sprintf("%d", u)), ",")
	}
	return []byte(result), nil
}

type Param1 struct {
	Content []byte `json:"content"`
	Public  string `json:"public"`
	Sig     string `json:"sig"`
}

type Param2 struct {
	Content JSONableSlice `json:"content"`
	Public  string        `json:"public"`
	Sig     string        `json:"sig"`
}

func init() {
	// init log
	log.SetFlags(log.Lshortfile)
}

func main() {
	content := []byte("firefly")
	public := "pp"
	sig := "ss"
	log.Printf("content: %v", content)
	log.Printf("public: %v", public)
	log.Printf("sig: %v", sig)

	log.Println(strings.Repeat("-", 50))

	p1 := Param1{
		Content: content,
		Public:  public,
		Sig:     sig,
	}
	rr1, err := json.Marshal(p1)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("json中的byte数组 默认json编码")
	log.Printf("rr1: %s", string(rr1)) //content 因为是byte数组，默认用base64编码成string
	contentBase64 := base64.StdEncoding.EncodeToString(content)
	log.Printf("contentBase64: %s", contentBase64)

	log.Println("json中的byte数组 默认json解码")
	var r1Decode Param1
	err = json.Unmarshal(rr1, &r1Decode)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("r1Decode: %+v", r1Decode)
	log.Printf(string(r1Decode.Content))

	log.Println(strings.Repeat("-", 50))

	log.Println("json中的byte数组 自定义byte数组编码的json编码,保留byte数组原始数据")
	p2 := Param2{
		Content: content,
		Public:  public,
		Sig:     sig,
	}
	rr2, err := json.Marshal(p2)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("rr2: %s", string(rr2))

	log.Printf("json中的byte数组 自定义byte数组编码解码的json解码,使用byte数组原始数据赋值到结构体")
	var r2Decode Param2
	err = json.Unmarshal(rr2, &r2Decode)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("r2Decode: %+v", r2Decode)
	log.Printf(string(r2Decode.Content))
}
```

输出
```
main.go:44: content: [102 105 114 101 102 108 121]
main.go:45: public: pp
main.go:46: sig: ss
main.go:48: --------------------------------------------------
main.go:59: json中的byte数组 默认json编码
main.go:60: rr1: {"content":"ZmlyZWZseQ==","public":"pp","sig":"ss"}
main.go:62: contentBase64: ZmlyZWZseQ==
main.go:64: json中的byte数组 默认json解码
main.go:70: r1Decode: {Content:[102 105 114 101 102 108 121] Public:pp Sig:ss}
main.go:71: firefly
main.go:73: --------------------------------------------------
main.go:75: json中的byte数组 自定义byte数组编码的json编码,保留byte数组原始数据
main.go:85: rr2: {"content":[102,105,114,101,102,108,121],"public":"pp","sig":"ss"}
main.go:87: json中的byte数组 自定义byte数组编码解码的json解码,使用byte数组原始数据赋值到结构体
main.go:93: r2Decode: {Content:[102 105 114 101 102 108 121] Public:pp Sig:ss}
main.go:94: firefly
```


参考：[https://stackoverflow.com/questions/14177862/how-to-marshal-a-byte-uint8-array-as-json-array-in-go/14178407#14178407](https://stackoverflow.com/questions/14177862/how-to-marshal-a-byte-uint8-array-as-json-array-in-go/14178407#14178407)

