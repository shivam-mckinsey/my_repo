# Multiprocessing Vs Multi-threading in Python 
# In Python multithreading is a myth and is usally called as psuedo multi-threading due to GIL (Global Interpretor Lock)
# Multi-threading - It is fast as the function to be applied and data is just on same process and can be shared. 
# Exchange of data between threads is quite convinent & fast. 
# 
# Because the data cant be shared between processes and cant modify the same memory concurrently - Thus making Mutliprocessing a more efficient way. 
# but again this is a disadvantage as now there is a I/O overhead from data being shuffled around different processes
# also the entire memory is copied into each subprocess, which can be a lot of overhead for more significant program

# Multiprocessing has 2 API's - 1. Processes 2. Pool 
# Pool has again 2 interfaces 1. .map and 2. apply_async
# # Source -https://stackoverflow.com/a/8533626
#                   | Multi-args   Concurrence    Blocking     Ordered-results
# ---------------------------------------------------------------------
# Pool.map          | no           yes            yes          yes
# Pool.map_async    | no           yes            no           yes
# Pool.apply        | yes          no             yes          no
# Pool.apply_async  | yes          yes            no           no
# Pool.starmap      | yes          yes            yes          yes
# Pool.starmap_async| yes          yes            no           no

# Pool - apply_async
from multiprocessing import Pool
import time 
from datetime import datetime

work = (["A", 2], ["B", 11], ["C", 1], ["D", 3], ["E", 2], ["F", 5])

def work_log_1(work_data):
   print(" Process %s waiting %s seconds" % (work_data[0], work_data[1]))
   time.sleep(int(work_data[1]))
   print(" Process %s Finished." % work_data[0])
   return work_data[1]

def work_log_2(i, j):
   print(" Process %s waiting %s seconds" % (i, j))
   time.sleep(int(j))
   print(" Process %s Finished." % i)
   return j

# def pool_handler(bigList, n_jobs=1):
#    pool=Pool(processes=n_jobs)
#    batches = []
#    for i,j in bigList:
#       #batches.append(pool.apply_async(work_log_1, ([i,j] ,)))   # Remember this comma after the list, as if expects the args in comma-seperated format.
#       batches.append(pool.apply_async(work_log_2, (i, j)))
#    result = [batch.get() for batch in batches]
#    print(result)
#    return result
   
# if __name__ == '__main__':
#    start_time = datetime.now()
#    n_jobs = 1
#    pool_handler(work, n_jobs=n_jobs)
#    print(f"Total time taken with {n_jobs} CPU is {datetime.now() - start_time}")

# Pool - map

def pool_handler(n_jobs=1):
    p = Pool(n_jobs)
    print(p.map(work_log_1, work))

if __name__ == '__main__':
   start_time = datetime.now()
   n_jobs = 5
   pool_handler(n_jobs=n_jobs)
   print(f"Total time taken with {n_jobs} CPU is {datetime.now() - start_time}")
   # for i in work:
   #     work_log(i)