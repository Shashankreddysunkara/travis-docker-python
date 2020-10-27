"""
Fibonacci numbers test class.
"""

# Copyright 2014 The University of Edinburgh.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
from python_travis_docker_test.python_travis_docker_test.fibonacci import fibonacci


class TestFibonacci(object):
    """
    Fibonacci numbers test class.
    """

    def test_fibonacci0(self):
        """ Test fibonacci(0). """
        self.assertEqual(0, fibonacci(0))

    def test_fibonacci1(self):
        """ Test fibonacci(1). """
        self.assertEqual(1, fibonacci(1))

    def test_fibonacci2(self):
        """ Test fibonacci(2). """
        self.assertEqual(1, fibonacci(2))

    def test_fibonacci3(self):
        """ Test fibonacci(3). """
        self.assertEqual(2, fibonacci(3))

    def test_fibonacci30(self):
        """ Test fibonacci(30). """
        self.assertEqual(832040, fibonacci(30))

    def assertEqual(self, a, b):
        assert a == b