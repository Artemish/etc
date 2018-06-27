import sh
import collections
import sys
import pprint

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
        # print("Exploring " + parent_lib)
        for child_lib, child_path in process(parent_path):
            graph[child_lib]['parent'] = parent_lib

            if child_lib not in seen:
                exploration_queue.append((child_lib, child_path))

    return graph

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: ldso_walker.py <executable>")
        print("")
        print("       Uses ldd to gather the runtime")
        print("       dependencies for the given executable")
        print("       and print out the tree. This is useful")
        print("       for determining the 'core' requirements")
        print("       for statically compiling the binary")
        sys.exit(1)

    graph = walk(sys.argv[1])

    base_deps = [lib for lib in graph if graph[lib]['parent'] == 'Base']
    print("Base dependencies:")
    for dep in base_deps:
        print(dep)
