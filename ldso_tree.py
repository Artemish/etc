import sh
import collections

def process(lib):
  output = sh.ldd(lib)
  entries = []
  for line in output.split('\n'):
    if '=>' not in line:
      continue

    tokens = line.split()

    (libname, path) = tokens[0], tokens[2]
    entries.append((libname, path))

  return entries

def walk(start):
    graph = collections.defaultdict(dict)

    exploration_queue = [("Base", start)]

    seen = set([start])

    while len(exploration_queue) > 0:
        parent_lib, parent_path = exploration_queue.pop()
        seen.add(parent_lib)
        print("Exploring " + parent_lib)
        for child_lib, child_path in process(parent_path):
            graph[child_lib]['parent'] = parent_lib

            if child_lib not in seen:
                exploration_queue.append((child_lib, child_path))

    return graph
