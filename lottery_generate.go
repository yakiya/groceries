//lottery generate

package main

import (
    "fmt"
    "math/rand"
    "time"
)

//生成n個不重複隨機數
func main() {
    //times
    for i := 0; i < 20; i++ {
        nums := lotterRandomGenerate(1, 49, 6)
        fmt.Println(nums)
    }
}

//生成[start, end]不重複的隨機數
func lotterRandomGenerate(start int, end int, count int) []int {
    //range check
    if end < start || (end-start) < count {
        return nil
    }
    
    //store results slice
    nums := make([]int, 0)
    
    //random nums generate, make sure no nums repeat
    r := rand.New(rand.NewSource(time.now().UnixNano()))
    for len(nums) < count {
        num := r.Intn((end-start)) + start
        
        // check repeat
        exist := false
        for _, v := range nums {
            if v == num {
                exist = true
                break
            }
        }
        if !exist {
            nums = append(nums, num)
        }
    }
    return nums
}
