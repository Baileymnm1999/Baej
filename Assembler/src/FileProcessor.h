#include <map>
#include <fstream>
#include <vector>
#include <string>

class FileProcessor
{
private:
  static std::map<std::string, int> registerMap;
  static std::map<std::string, int> opMap;
  std::map<std::string, int *> labelMap;
  std::vector<Instruction> instructions;
  std::fstream inFile;
  std::ofstream outFile;

public:
  FileProcessor(char *);
  void parseToken(Instruction *, std::string);
  void execute();
};