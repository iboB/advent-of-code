use std::fs::File;
use std::io::{self, BufRead};

const LIM: usize = 2020;

fn s2(min: usize, sum: usize, map: &[usize]) -> Option<usize> {
    let mut half = sum / 2;
    if sum % 2 == 0 {
        if map[half] > 1 { return Some(half*half); }
        half -= 1;
    }

    for i in min..=half {
        let n = map[i];
        if n == 0 { continue; }
        if map[sum - i] > 0 {
            return Some(i * (sum-i));
        }
    }

    return None;
}

fn s3(map: [usize; LIM+1]) -> Option<usize> {
    const THIRD: usize = LIM/3;

    for i in 0..=THIRD {
        let n = map[i];
        if n == 0 { continue; }
        let min = if n > 1 { i } else { i+1 };
        if let Some(p) = s2(min, LIM-i, &map) {
            return Some(i*p);
        }
    }

    return None;
}

fn main() {
    let file = match File::open("input.txt") {
        Err(why) => panic!("can't open input: {}", why),
        Ok(file) => file,
    };


    let mut map = [0 as usize; LIM+1];
    let br = io::BufReader::new(file);
    for line in br.lines() {
        let i = line.unwrap().parse::<usize>().unwrap();
        if i > LIM { continue; }
        map[i] += 1
    }

    // solution to A
    // println!("{:?}", s2(0, LIM, &map))

    // solution to B
    println!("{:?}", s3(map))
}
