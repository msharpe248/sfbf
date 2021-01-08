global class SFBF_brainFarkInterpreter {
   public List<Integer> output;
   
   public Integer execute(String program, List<Integer> input) {
      List<Integer> memory = new List<Integer>();
      List<Integer> callStack = new List<Integer>();
      output = new List<Integer>();
      Integer p = 0;
      Integer pc = 0;
      Integer c;
      Integer i = 0;
      Integer progLen = program.length();

      // Initialize the memory
      memory.add(0); 
      Integer m;     
      for (m = 0; m < 16; m++) {
        memory.addAll(memory);
      }
      
      while (pc < progLen) {
         c = program.charAt(pc);
         if (c == '>'.charAt(0)) {
            p = p + 1;
         } else if (c == '<'.charAt(0)) {
            if (p != 0) {
               p--;
            }
         } else if (c == '+'.charAt(0)) {
            memory[p] = memory[p] + 1;
         } else if (c == '-'.charAt(0)) {
            memory[p] = memory[p] - 1;
         } else if (c == ','.charAt(0)) {
            if (input != null && i < input.size()) {
               memory[p] = input[i];
               i++;
            }
         } else if (c == '.'.charAt(0)) {
            output.add(memory[p]);
         } else if (c == '['.charAt(0)) {
            if (memory[p] == 0) {
               Integer depth = 0;
               pc++;
               while (pc < progLen) {
                  c = program.charAt(pc);
                  if (c == '['.charAt(0)) {
                     depth++;
                  } else if (c == ']'.charAt(0)) {
                     if (depth != 0) {
                        depth--;
                     } else {
                        break;
                     }
                  }
                  pc++;
               }
            } else {
               callStack.add(pc);
            }
         } else if (c == ']'.charAt(0)) {
            if (memory[p] == 0) {
               callStack.remove(callStack.size() - 1);
            } else {
               pc = callStack[callStack.size() - 1];
            }
         } else if (c == 'm'.charAt(0)) {
            System.debug(memory);
            System.debug(pc);
         } else if (c == 'o'.charAt(0)) {
            System.debug(output);
         } else if (c == 'x'.charAt(0)) {
            return 0;
         }
         pc++;
     }
     return 0;
   }
   
   public Integer execute(String program, String input) {
      Integer[] chars = null;
      if (input != null) {
         chars = input.getChars();
      }
      return execute(program, chars);
   }

   public String getOutputAsString() {
       return String.fromCharArray(output);
   }
}
