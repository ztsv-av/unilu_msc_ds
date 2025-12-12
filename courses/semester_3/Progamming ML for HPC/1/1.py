import sys
import os
from multiprocessing import Pool, Process

# a = []
# b = a

# def f(x):
#     return x*x

# if __name__ == '__main__':
#     with Pool(5) as p:
#         print(p.map(f, [1, 2, 3]))
#     print(sys.getrefcount(a))
    
# def info(title):
#     print(title)
#     print('module name:', __name__)
#     print('parent process:', os.getppid())
#     print('process id:', os.getpid())

# def f(name):
#     info('function f')
#     print('hello', name)

# if __name__ == '__main__':
#     info('main line')
#     p = Process(target=f, args=('bob',))
#     p.start()
#     p.join()

import multiprocessing as mp

def foo(q, str):
    q.put(str) # put 'hello' into que

if __name__ == '__main__':
    mp.set_start_method('spawn')
    q = mp.Queue() # structure used to share data between processes
    p = mp.Process(target=foo, args=(q,'first',))
    p2 = mp.Process(target=foo, args=(q,'second',))
    p.start()
    p2.start()
    print(q.get()) # this will only retrieve the first item added (likely from p, but the order is not guaranteed due to the asynchronous nature of multiprocessing).
    print(q.get())
    p.join() # main process waits until p finishes executing
    p2.join()